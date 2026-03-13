import Foundation
import SwiftUI

final class MealPlanStore: ObservableObject {
    @AppStorage("mealplan.language") private var languageRaw: String = AppLanguage.chinese.rawValue
    var language: AppLanguage {
        get { AppLanguage(rawValue: languageRaw) ?? .chinese }
        set { languageRaw = newValue.rawValue }
    }

    @Published var selectedTemplate: MealTemplate = .balanced
    @Published var groceryDays: Set<Weekday> = [.sunday]
    @Published var nutritionGoals = NutritionGoals()
    @Published private(set) var currentPlan: WeeklyPlan? = nil
    private var lastPlan: WeeklyPlan? = nil

    func generatePlan(repeatLastWeek: Bool = false) {
        if repeatLastWeek, let lastPlan {
            currentPlan = lastPlan
            return
        }

        let start = Calendar.current.startOfDay(for: Date())
        let recipes = SampleRecipes.recipes(for: selectedTemplate)
        let dayPlans = (0..<7).compactMap { offset -> DayPlan? in
            guard let date = Calendar.current.date(byAdding: .day, value: offset, to: start) else { return nil }
            var meals: [MealType: [Recipe]] = [:]
            for mealType in MealType.allCases {
                let candidates = recipes.filter { $0.mealType == mealType }
                let mealRecipes = pickRecipes(from: candidates, seed: offset)
                meals[mealType] = mealRecipes
            }
            return DayPlan(date: date, meals: meals)
        }

        let plan = WeeklyPlan(startDate: start, days: dayPlans)
        lastPlan = currentPlan
        currentPlan = plan
    }

    func groceryTrips(for plan: WeeklyPlan) -> [GroceryTrip] {
        let sortedDays = groceryDays.sorted { $0.rawValue < $1.rawValue }
        guard !sortedDays.isEmpty else { return [] }

        var grouped: [Weekday: [Ingredient]] = [:]
        for day in sortedDays {
            grouped[day] = []
        }

        for dayPlan in plan.days {
            let weekday = Weekday(rawValue: Calendar.current.component(.weekday, from: dayPlan.date)) ?? .sunday
            let targetDay = nearestGroceryDay(from: weekday, available: sortedDays)
            let ingredients = dayPlan.meals.values.flatMap { $0.flatMap { $0.ingredients } }
            grouped[targetDay, default: []].append(contentsOf: ingredients)
        }

        return sortedDays.map { day in
            let items = aggregate(ingredients: grouped[day, default: []])
            return GroceryTrip(weekday: day, items: items)
        }
    }

    private func nearestGroceryDay(from weekday: Weekday, available: [Weekday]) -> Weekday {
        if let next = available.first(where: { $0.rawValue >= weekday.rawValue }) {
            return next
        }
        return available.first ?? .sunday
    }

    private func pickRecipes(from recipes: [Recipe], seed: Int) -> [Recipe] {
        guard !recipes.isEmpty else { return [] }
        if recipes.count == 1 { return recipes }
        let first = recipes[seed % recipes.count]
        let second = recipes[(seed + 1) % recipes.count]
        if first.id == second.id { return [first] }
        return [first, second]
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
