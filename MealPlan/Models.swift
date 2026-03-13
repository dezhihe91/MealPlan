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
    let calories: Double?
    let protein: Double?
    let carbs: Double?
    let fat: Double?

    init(
        name: String,
        quantity: Double,
        unit: String,
        category: IngredientCategory,
        calories: Double? = nil,
        protein: Double? = nil,
        carbs: Double? = nil,
        fat: Double? = nil
    ) {
        self.name = name
        self.quantity = quantity
        self.unit = unit
        self.category = category
        self.calories = calories
        self.protein = protein
        self.carbs = carbs
        self.fat = fat
    }
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
    let calories: Int?
    let protein: Int?
    let carbs: Int?
    let fat: Int?
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
        calories: Int? = nil,
        protein: Int? = nil,
        carbs: Int? = nil,
        fat: Int? = nil,
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
        self.calories = calories
        self.protein = protein
        self.carbs = carbs
        self.fat = fat
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

    func displayCuisine(for language: AppLanguage) -> String? {
        guard let cuisine, !cuisine.isEmpty else { return nil }
        if language == .english {
            let map: [String: String] = ["川菜": "Sichuan", "湘菜": "Hunan", "粤菜": "Cantonese", "家常": "Home-style"]
            return map[cuisine] ?? cuisine
        }
        return cuisine
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
    case custom

    var id: String { rawValue }
    func title(for language: AppLanguage) -> String {
        switch (self, language) {
        case (.balanced, .chinese): return "日常均衡"
        case (.pregnancy, .chinese): return "孕期营养"
        case (.muscleGain, .chinese): return "健身增肌"
        case (.fatLoss, .chinese): return "减脂控卡"
        case (.mediterranean, .chinese): return "地中海"
        case (.chinese, .chinese): return "中餐经典"
        case (.custom, .chinese): return "自定义"
        case (.balanced, .english): return "Balanced"
        case (.pregnancy, .english): return "Pregnancy"
        case (.muscleGain, .english): return "Muscle Gain"
        case (.fatLoss, .english): return "Fat Loss"
        case (.mediterranean, .english): return "Mediterranean"
        case (.chinese, .english): return "Chinese"
        case (.custom, .english): return "Custom"
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

extension Ingredient {
    func estimatedMacros() -> (calories: Double, protein: Double, carbs: Double, fat: Double) {
        if let calories, let protein, let carbs, let fat {
            return (calories, protein, carbs, fat)
        }
        // crude estimates per 100g based on category
        let grams = unit == "g" ? quantity : (unit == "ml" ? quantity : 0)
        let factor = grams / 100.0
        switch category {
        case .protein:
            return (165 * factor, 31 * factor, 0 * factor, 4 * factor)
        case .produce:
            return (40 * factor, 1 * factor, 9 * factor, 0.2 * factor)
        case .grains:
            return (360 * factor, 10 * factor, 75 * factor, 2 * factor)
        case .dairy:
            return (60 * factor, 3 * factor, 5 * factor, 3 * factor)
        case .pantry:
            return (200 * factor, 5 * factor, 20 * factor, 10 * factor)
        case .spices, .other:
            return (5 * factor, 0 * factor, 1 * factor, 0 * factor)
        }
    }
}

extension Ingredient {
    func displayName(for language: AppLanguage) -> String {
        guard language == .english else { return name }
        let map: [String: String] = [
            "盐": "Salt",
            "食用油": "Cooking oil",
            "鸡胸肉": "Chicken breast",
            "黄瓜": "Cucumber",
            "蒜": "Garlic",
            "葱": "Scallion",
            "酱油": "Soy sauce",
            "牛肉": "Beef",
            "五花肉": "Pork belly",
            "排骨": "Pork ribs",
            "冬瓜": "Winter melon",
            "豆腐": "Tofu",
            "木耳": "Wood ear mushrooms",
            "番茄": "Tomato",
            "青菜": "Greens",
            "西兰花": "Broccoli",
            "鸡蛋": "Egg",
            "牛腩": "Beef brisket",
            "鱼头": "Fish head",
            "鱼片": "Fish slices",
            "剁椒": "Chopped chiles",
            "泡椒": "Pickled chiles",
            "青蒜": "Garlic shoots",
            "尖椒": "Green chiles",
            "花生": "Peanuts",
            "花椒": "Sichuan peppercorns",
            "姜": "Ginger",
            "紫菜": "Seaweed",
            "皮蛋": "Century egg",
            "瘦肉": "Lean pork",
            "豆浆": "Soy milk",
            "油条": "Youtiao",
            "面条": "Noodles",
            "大米": "Rice",
            "燕麦": "Oats",
            "小米": "Millet",
            "南瓜": "Pumpkin",
            "红枣": "Jujube",
            "枸杞": "Goji berries",
            "虾仁": "Shrimp",
            "葱姜": "Scallion & ginger",
            "豆瓣酱": "Doubanjiang",
            "豆豉": "Fermented black beans",
            "白萝卜": "Daikon",
            "橄榄油": "Olive oil",
            "鹰嘴豆": "Chickpeas",
            "藜麦": "Quinoa",
            "米饭": "Cooked rice"
        ]
        return map[name] ?? name
    }
}

extension Recipe {
    func estimatedNutrition() -> (calories: Int, protein: Int, carbs: Int, fat: Int) {
        let totals = ingredients.reduce((0.0, 0.0, 0.0, 0.0)) { acc, item in
            let m = item.estimatedMacros()
            return (acc.0 + m.calories, acc.1 + m.protein, acc.2 + m.carbs, acc.3 + m.fat)
        }
        return (Int(totals.0.rounded()), Int(totals.1.rounded()), Int(totals.2.rounded()), Int(totals.3.rounded()))
    }
}
