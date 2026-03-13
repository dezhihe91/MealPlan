import Foundation

enum AppLanguage: String, CaseIterable, Identifiable {
    case chinese
    case english

    var id: String { rawValue }
}

enum MealType: String, CaseIterable, Identifiable {
    case breakfast
    case lunch
    case dinner

    var id: String { rawValue }
    func title(for language: AppLanguage) -> String {
        switch (self, language) {
        case (.breakfast, .chinese): return "早餐"
        case (.lunch, .chinese): return "午餐"
        case (.dinner, .chinese): return "晚餐"
        case (.breakfast, .english): return "Breakfast"
        case (.lunch, .english): return "Lunch"
        case (.dinner, .english): return "Dinner"
        }
    }
}

enum IngredientCategory: String, CaseIterable, Identifiable {
    case produce
    case protein
    case dairy
    case grains
    case pantry
    case spices
    case other

    var id: String { rawValue }
    func title(for language: AppLanguage) -> String {
        switch (self, language) {
        case (.produce, .chinese): return "蔬果"
        case (.protein, .chinese): return "蛋白"
        case (.dairy, .chinese): return "乳制品"
        case (.grains, .chinese): return "主食"
        case (.pantry, .chinese): return "干货"
        case (.spices, .chinese): return "调味"
        case (.other, .chinese): return "其他"
        case (.produce, .english): return "Produce"
        case (.protein, .english): return "Protein"
        case (.dairy, .english): return "Dairy"
        case (.grains, .english): return "Grains"
        case (.pantry, .english): return "Pantry"
        case (.spices, .english): return "Spices"
        case (.other, .english): return "Other"
        }
    }
}

struct Ingredient: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let quantity: Double
    let unit: String
    let category: IngredientCategory
}

struct Recipe: Identifiable {
    let id = UUID()
    let name: String
    let nameEn: String?
    let mealType: MealType
    let ingredients: [Ingredient]
    let instructions: String
    let instructionsEn: String?
    let nutrition: String?
    let nutritionEn: String?
    let prepMinutes: Int?
    let cookMinutes: Int?
    let isSoup: Bool
    let cuisine: String?

    init(
        name: String,
        nameEn: String? = nil,
        mealType: MealType,
        ingredients: [Ingredient],
        instructions: String,
        instructionsEn: String? = nil,
        nutrition: String? = nil,
        nutritionEn: String? = nil,
        prepMinutes: Int? = nil,
        cookMinutes: Int? = nil,
        isSoup: Bool = false,
        cuisine: String? = nil
    ) {
        self.name = name
        self.nameEn = nameEn
        self.mealType = mealType
        self.ingredients = ingredients
        self.instructions = instructions
        self.instructionsEn = instructionsEn
        self.nutrition = nutrition
        self.nutritionEn = nutritionEn
        self.prepMinutes = prepMinutes
        self.cookMinutes = cookMinutes
        self.isSoup = isSoup
        self.cuisine = cuisine
    }

    func displayName(for language: AppLanguage) -> String {
        if language == .english {
            return nameEn ?? name
        }
        return name
    }

    func displayInstructions(for language: AppLanguage) -> String {
        if language == .english {
            if let instructionsEn, instructionsEn != "See Chinese steps" {
                return instructionsEn
            }
            return instructions
        }
        return instructions
    }

    func displayNutrition(for language: AppLanguage) -> String? {
        if language == .english {
            return nutritionEn ?? nutrition
        }
        return nutrition
    }
}

enum MealTemplate: String, CaseIterable, Identifiable {
    case balanced
    case pregnancy
    case muscleGain
    case fatLoss
    case mediterranean
    case chinese

    var id: String { rawValue }
    func title(for language: AppLanguage) -> String {
        switch (self, language) {
        case (.balanced, .chinese): return "日常均衡"
        case (.pregnancy, .chinese): return "孕期营养"
        case (.muscleGain, .chinese): return "健身增肌"
        case (.fatLoss, .chinese): return "减脂控卡"
        case (.mediterranean, .chinese): return "地中海"
        case (.chinese, .chinese): return "中餐经典"
        case (.balanced, .english): return "Balanced"
        case (.pregnancy, .english): return "Pregnancy"
        case (.muscleGain, .english): return "Muscle Gain"
        case (.fatLoss, .english): return "Fat Loss"
        case (.mediterranean, .english): return "Mediterranean"
        case (.chinese, .english): return "Chinese"
        }
    }
}

struct DayPlan: Identifiable {
    let id = UUID()
    let date: Date
    let meals: [MealType: [Recipe]]
}

struct WeeklyPlan {
    let startDate: Date
    let days: [DayPlan]
}

enum Weekday: Int, CaseIterable, Identifiable {
    case sunday = 1
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday

    var id: Int { rawValue }
    func title(for language: AppLanguage) -> String {
        switch (self, language) {
        case (.sunday, .chinese): return "周日"
        case (.monday, .chinese): return "周一"
        case (.tuesday, .chinese): return "周二"
        case (.wednesday, .chinese): return "周三"
        case (.thursday, .chinese): return "周四"
        case (.friday, .chinese): return "周五"
        case (.saturday, .chinese): return "周六"
        case (.sunday, .english): return "Sun"
        case (.monday, .english): return "Mon"
        case (.tuesday, .english): return "Tue"
        case (.wednesday, .english): return "Wed"
        case (.thursday, .english): return "Thu"
        case (.friday, .english): return "Fri"
        case (.saturday, .english): return "Sat"
        }
    }
}

struct GroceryTrip: Identifiable {
    let id = UUID()
    let weekday: Weekday
    let items: [Ingredient]
}

struct NutritionGoals {
    var calories: Int = 0
    var protein: Int = 0
    var carbs: Int = 0
    var fat: Int = 0
}
