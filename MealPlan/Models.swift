import Foundation

enum MealType: String, CaseIterable, Identifiable {
    case breakfast
    case lunch
    case dinner

    var id: String { rawValue }
    var title: String { rawValue.capitalized }
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
    var title: String {
        switch self {
        case .produce: return "Produce"
        case .protein: return "Protein"
        case .dairy: return "Dairy"
        case .grains: return "Grains"
        case .pantry: return "Pantry"
        case .spices: return "Spices"
        case .other: return "Other"
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
    let mealType: MealType
    let ingredients: [Ingredient]
    let instructions: String
    let nutrition: String?
}

enum MealTemplate: String, CaseIterable, Identifiable {
    case balanced
    case pregnancy
    case muscleGain
    case fatLoss
    case mediterranean

    var id: String { rawValue }
    var title: String {
        switch self {
        case .balanced: return "Balanced"
        case .pregnancy: return "Pregnancy"
        case .muscleGain: return "Muscle Gain"
        case .fatLoss: return "Fat Loss"
        case .mediterranean: return "Mediterranean"
        }
    }
}

struct DayPlan: Identifiable {
    let id = UUID()
    let date: Date
    let meals: [MealType: Recipe]
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
    var title: String {
        switch self {
        case .sunday: return "Sun"
        case .monday: return "Mon"
        case .tuesday: return "Tue"
        case .wednesday: return "Wed"
        case .thursday: return "Thu"
        case .friday: return "Fri"
        case .saturday: return "Sat"
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
