import Foundation
import SwiftUI

final class MealPlanStore: ObservableObject {
    @AppStorage("mealplan.language") private var languageRaw: String = AppLanguage.chinese.rawValue
    var language: AppLanguage {
        get { AppLanguage(rawValue: languageRaw) ?? .chinese }
        set { languageRaw = newValue.rawValue }
    }

    @AppStorage("mealplan.likedIds") private var likedIdsStorage: String = ""

    @Published var selectedTemplate: MealTemplate = .balanced
    @Published var groceryDays: Set<Weekday> = [.sunday]
    @Published var nutritionGoals = NutritionGoals()
    @Published var customRecipes: [Recipe] = []
    @Published var candidateIds: Set<UUID> = []
    @Published var likedIds: Set<UUID> = [] {
        didSet {
            likedIdsStorage = likedIds.map { $0.uuidString }.joined(separator: ",")
        }
    }

    @AppStorage("mealplan.reminderEnabled") var reminderEnabled: Bool = false
    @AppStorage("mealplan.reminderTime") private var reminderTimeInterval: Double = Date().timeIntervalSince1970

    init() {
        let stored = likedIdsStorage
            .split(separator: ",")
            .compactMap { UUID(uuidString: String($0)) }
        likedIds = Set(stored)
    }

    var reminderTime: Date {
        get { Date(timeIntervalSince1970: reminderTimeInterval) }
        set { reminderTimeInterval = newValue.timeIntervalSince1970 }
    }
    @Published private(set) var currentPlan: WeeklyPlan? = nil
    private var lastPlan: WeeklyPlan? = nil

    var allRecipes: [Recipe] {
        SampleRecipes.allRecipes() + customRecipes
    }

    func addCustomRecipe(_ recipe: Recipe) {
        customRecipes.insert(recipe, at: 0)
    }

    func generatePlan(repeatLastWeek: Bool = false) {
        if repeatLastWeek, let lastPlan {
            currentPlan = lastPlan
            return
        }

        let start = Calendar.current.startOfDay(for: Date())
        let recipes = candidatePool()

        var pools: [MealType: [Recipe]] = [:]
        var soupPools: [MealType: [Recipe]] = [:]
        var mainPools: [MealType: [Recipe]] = [:]
        var indices: [MealType: Int] = [:]
        var soupIndices: [MealType: Int] = [:]
        var mainIndices: [MealType: Int] = [:]

        for mealType in MealType.allCases {
            let candidates = recipes.filter { $0.mealType == mealType }
            pools[mealType] = candidates.shuffled()
            soupPools[mealType] = candidates.filter { $0.isSoup }.shuffled()
            mainPools[mealType] = candidates.filter { !$0.isSoup }.shuffled()
            indices[mealType] = 0
            soupIndices[mealType] = 0
            mainIndices[mealType] = 0
        }

        let dayPlans = (0..<7).compactMap { offset -> DayPlan? in
            guard let date = Calendar.current.date(byAdding: .day, value: offset, to: start) else { return nil }
            var meals: [MealType: [Recipe]] = [:]
            for mealType in MealType.allCases {
                var pool = pools[mealType] ?? []
                var poolIndex = indices[mealType] ?? 0
                var soupPool = soupPools[mealType] ?? []
                var soupIndex = soupIndices[mealType] ?? 0
                var mainPool = mainPools[mealType] ?? []
                var mainIndex = mainIndices[mealType] ?? 0

                let mealRecipes = pickRecipesRandom(
                    pool: &pool,
                    poolIndex: &poolIndex,
                    soupPool: &soupPool,
                    soupIndex: &soupIndex,
                    mainPool: &mainPool,
                    mainIndex: &mainIndex
                )

                pools[mealType] = pool
                indices[mealType] = poolIndex
                soupPools[mealType] = soupPool
                soupIndices[mealType] = soupIndex
                mainPools[mealType] = mainPool
                mainIndices[mealType] = mainIndex

                meals[mealType] = mealRecipes
            }
            return DayPlan(date: date, meals: meals)
        }

        let plan = WeeklyPlan(startDate: start, days: dayPlans)
        lastPlan = currentPlan
        currentPlan = plan
    }

    func regenerateMeal(dayId: UUID, mealType: MealType) {
        guard var plan = currentPlan else { return }
        let recipes = candidatePool().filter { $0.mealType == mealType }
        guard !recipes.isEmpty else { return }
        var pool = recipes.shuffled()
        var soupPool = recipes.filter { $0.isSoup }.shuffled()
        var mainPool = recipes.filter { !$0.isSoup }.shuffled()
        var poolIndex = 0
        var soupIndex = 0
        var mainIndex = 0

        let newMeals = pickRecipesRandom(
            pool: &pool,
            poolIndex: &poolIndex,
            soupPool: &soupPool,
            soupIndex: &soupIndex,
            mainPool: &mainPool,
            mainIndex: &mainIndex
        )

        if let idx = plan.days.firstIndex(where: { $0.id == dayId }) {
            var day = plan.days[idx]
            day.meals[mealType] = newMeals
            var updatedDays = plan.days
            updatedDays[idx] = day
            currentPlan = WeeklyPlan(startDate: plan.startDate, days: updatedDays)
        }
    }

    func groceryTrips(for plan: WeeklyPlan) -> [GroceryTrip] {
        let sortedDays = groceryDays.sorted { $0.rawValue < $1.rawValue }
        guard !sortedDays.isEmpty else { return [] }

        let calendar = Calendar.current

        var tripItems: [Weekday: [Ingredient]] = [:]
        for day in sortedDays { tripItems[day] = [] }

        for (index, tripDay) in sortedDays.enumerated() {
            let startDay = tripDay
            let endDay = index + 1 < sortedDays.count ? sortedDays[index + 1] : nil

            for dayPlan in plan.days {
                let weekday = Weekday(rawValue: calendar.component(.weekday, from: dayPlan.date)) ?? .sunday
                if isInRange(weekday: weekday, start: startDay, end: endDay) {
                    let ingredients = dayPlan.meals.values.flatMap { $0.flatMap { $0.ingredients } }
                    tripItems[tripDay, default: []].append(contentsOf: ingredients)
                }
            }
        }

        return sortedDays.map { day in
            let items = aggregate(ingredients: tripItems[day, default: []])
            return GroceryTrip(weekday: day, items: items)
        }
    }

    private func isInRange(weekday: Weekday, start: Weekday, end: Weekday?) -> Bool {
        if let end {
            if start.rawValue <= end.rawValue {
                return weekday.rawValue >= start.rawValue && weekday.rawValue < end.rawValue
            } else {
                return weekday.rawValue >= start.rawValue || weekday.rawValue < end.rawValue
            }
        }
        return weekday.rawValue >= start.rawValue
    }

    private func nearestGroceryDay(from weekday: Weekday, available: [Weekday]) -> Weekday {
        if let next = available.first(where: { $0.rawValue >= weekday.rawValue }) {
            return next
        }
        return available.first ?? .sunday
    }

    private func candidatePool() -> [Recipe] {
        let library = allRecipes
        if selectedTemplate == .custom {
            let pool = library.filter { candidateIds.contains($0.id) }
            return pool
        }
        if !candidateIds.isEmpty {
            let pool = library.filter { candidateIds.contains($0.id) }
            if !pool.isEmpty { return pool }
        }
        return SampleRecipes.recipes(for: selectedTemplate) + customRecipes
    }

    private func pickRecipesRandom(
        pool: inout [Recipe],
        poolIndex: inout Int,
        soupPool: inout [Recipe],
        soupIndex: inout Int,
        mainPool: inout [Recipe],
        mainIndex: inout Int
    ) -> [Recipe] {
        guard !pool.isEmpty else { return [] }

        if !soupPool.isEmpty && !mainPool.isEmpty {
            let main = nextRecipe(from: &mainPool, index: &mainIndex)
            let soup = nextRecipe(from: &soupPool, index: &soupIndex)
            return [main, soup].compactMap { $0 }
        }

        let first = nextRecipe(from: &pool, index: &poolIndex)
        let second = nextRecipe(from: &pool, index: &poolIndex)
        if let first, let second, first.id != second.id {
            return [first, second]
        }
        return [first].compactMap { $0 }
    }

    private func nextRecipe(from pool: inout [Recipe], index: inout Int) -> Recipe? {
        guard !pool.isEmpty else { return nil }
        if index >= pool.count {
            pool.shuffle()
            index = 0
        }
        let item = pool[index]
        index += 1
        return item
    }

    private func aggregate(ingredients: [Ingredient]) -> [Ingredient] {
        var map: [String: Ingredient] = [:]
        for item in ingredients {
            let key = "\(item.name.lowercased())|\(item.unit)|\(item.category.rawValue)"
            if let existing = map[key] {
                map[key] = Ingredient(
                    name: existing.name,
                    quantity: existing.quantity + item.quantity,
                    unit: existing.unit,
                    category: existing.category
                )
            } else {
                map[key] = item
            }
        }
        return map.values.sorted { $0.category.rawValue < $1.category.rawValue }
    }
}

private extension Array {
    subscript(safe index: Int) -> Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }
}
