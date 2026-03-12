import Foundation

struct SampleRecipes {
    static func recipes(for template: MealTemplate) -> [Recipe] {
        switch template {
        case .balanced:
            return balanced
        case .pregnancy:
            return pregnancy
        case .muscleGain:
            return muscleGain
        case .fatLoss:
            return fatLoss
        case .mediterranean:
            return mediterranean
        }
    }

    private static let balanced: [Recipe] = [
        Recipe(name: "Oatmeal + Berries", mealType: .breakfast, ingredients: [
            Ingredient(name: "Oats", quantity: 60, unit: "g", category: .grains),
            Ingredient(name: "Milk", quantity: 200, unit: "ml", category: .dairy),
            Ingredient(name: "Blueberries", quantity: 80, unit: "g", category: .produce)
        ], instructions: "Cook oats with milk. Top with berries.", nutrition: "Balanced carbs & fiber"),
        Recipe(name: "Turkey Sandwich", mealType: .lunch, ingredients: [
            Ingredient(name: "Whole wheat bread", quantity: 2, unit: "slices", category: .grains),
            Ingredient(name: "Turkey", quantity: 100, unit: "g", category: .protein),
            Ingredient(name: "Lettuce", quantity: 40, unit: "g", category: .produce)
        ], instructions: "Assemble sandwich and serve with greens.", nutrition: "Lean protein"),
        Recipe(name: "Salmon + Rice", mealType: .dinner, ingredients: [
            Ingredient(name: "Salmon", quantity: 150, unit: "g", category: .protein),
            Ingredient(name: "Brown rice", quantity: 80, unit: "g", category: .grains),
            Ingredient(name: "Broccoli", quantity: 120, unit: "g", category: .produce)
        ], instructions: "Bake salmon, steam broccoli, serve with rice.", nutrition: "Omega-3 + fiber"),
        Recipe(name: "Greek Yogurt Bowl", mealType: .breakfast, ingredients: [
            Ingredient(name: "Greek yogurt", quantity: 200, unit: "g", category: .dairy),
            Ingredient(name: "Banana", quantity: 1, unit: "piece", category: .produce),
            Ingredient(name: "Granola", quantity: 40, unit: "g", category: .grains)
        ], instructions: "Mix yogurt with fruit and granola.", nutrition: "Protein + carbs"),
        Recipe(name: "Chicken Salad", mealType: .lunch, ingredients: [
            Ingredient(name: "Chicken breast", quantity: 120, unit: "g", category: .protein),
            Ingredient(name: "Mixed greens", quantity: 80, unit: "g", category: .produce),
            Ingredient(name: "Olive oil", quantity: 10, unit: "ml", category: .pantry)
        ], instructions: "Grill chicken and toss with greens.", nutrition: "Light and filling"),
        Recipe(name: "Beef Stir Fry", mealType: .dinner, ingredients: [
            Ingredient(name: "Beef", quantity: 140, unit: "g", category: .protein),
            Ingredient(name: "Bell pepper", quantity: 100, unit: "g", category: .produce),
            Ingredient(name: "Rice", quantity: 80, unit: "g", category: .grains)
        ], instructions: "Stir fry beef and veggies. Serve with rice.", nutrition: "Iron + protein")
    ]

    private static let pregnancy: [Recipe] = [
        Recipe(name: "Spinach Egg Scramble", mealType: .breakfast, ingredients: [
            Ingredient(name: "Eggs", quantity: 2, unit: "pcs", category: .protein),
            Ingredient(name: "Spinach", quantity: 60, unit: "g", category: .produce),
            Ingredient(name: "Cheese", quantity: 20, unit: "g", category: .dairy)
        ], instructions: "Scramble eggs with spinach and cheese.", nutrition: "Folate + protein"),
        Recipe(name: "Lentil Soup", mealType: .lunch, ingredients: [
            Ingredient(name: "Lentils", quantity: 120, unit: "g", category: .pantry),
            Ingredient(name: "Carrots", quantity: 80, unit: "g", category: .produce),
            Ingredient(name: "Onion", quantity: 40, unit: "g", category: .produce)
        ], instructions: "Simmer lentils with veggies.", nutrition: "Iron + fiber"),
        Recipe(name: "Baked Cod + Sweet Potato", mealType: .dinner, ingredients: [
            Ingredient(name: "Cod", quantity: 150, unit: "g", category: .protein),
            Ingredient(name: "Sweet potato", quantity: 180, unit: "g", category: .produce),
            Ingredient(name: "Green beans", quantity: 100, unit: "g", category: .produce)
        ], instructions: "Bake cod and sweet potato. Steam beans.", nutrition: "Lean protein + vitamin A"),
        Recipe(name: "Avocado Toast", mealType: .breakfast, ingredients: [
            Ingredient(name: "Whole wheat bread", quantity: 2, unit: "slices", category: .grains),
            Ingredient(name: "Avocado", quantity: 1, unit: "piece", category: .produce),
            Ingredient(name: "Tomato", quantity: 60, unit: "g", category: .produce)
        ], instructions: "Mash avocado on toast, top with tomato.", nutrition: "Healthy fats"),
        Recipe(name: "Chickpea Bowl", mealType: .lunch, ingredients: [
            Ingredient(name: "Chickpeas", quantity: 120, unit: "g", category: .pantry),
            Ingredient(name: "Cucumber", quantity: 80, unit: "g", category: .produce),
            Ingredient(name: "Olive oil", quantity: 10, unit: "ml", category: .pantry)
        ], instructions: "Toss chickpeas with cucumber and olive oil.", nutrition: "Protein + fiber"),
        Recipe(name: "Chicken + Quinoa", mealType: .dinner, ingredients: [
            Ingredient(name: "Chicken breast", quantity: 140, unit: "g", category: .protein),
            Ingredient(name: "Quinoa", quantity: 70, unit: "g", category: .grains),
            Ingredient(name: "Zucchini", quantity: 100, unit: "g", category: .produce)
        ], instructions: "Cook quinoa, grill chicken, sauté zucchini.", nutrition: "Complete protein")
    ]

    private static let muscleGain: [Recipe] = [
        Recipe(name: "Protein Oats", mealType: .breakfast, ingredients: [
            Ingredient(name: "Oats", quantity: 80, unit: "g", category: .grains),
            Ingredient(name: "Milk", quantity: 250, unit: "ml", category: .dairy),
            Ingredient(name: "Peanut butter", quantity: 20, unit: "g", category: .pantry)
        ], instructions: "Cook oats with milk, stir in peanut butter.", nutrition: "High protein"),
        Recipe(name: "Chicken Burrito Bowl", mealType: .lunch, ingredients: [
            Ingredient(name: "Chicken breast", quantity: 160, unit: "g", category: .protein),
            Ingredient(name: "Rice", quantity: 100, unit: "g", category: .grains),
            Ingredient(name: "Beans", quantity: 80, unit: "g", category: .pantry)
        ], instructions: "Serve chicken over rice and beans.", nutrition: "Protein + carbs"),
        Recipe(name: "Steak + Potatoes", mealType: .dinner, ingredients: [
            Ingredient(name: "Steak", quantity: 180, unit: "g", category: .protein),
            Ingredient(name: "Potatoes", quantity: 200, unit: "g", category: .produce),
            Ingredient(name: "Asparagus", quantity: 100, unit: "g", category: .produce)
        ], instructions: "Grill steak, roast potatoes, steam asparagus.", nutrition: "High protein"),
        Recipe(name: "Egg & Turkey Muffins", mealType: .breakfast, ingredients: [
            Ingredient(name: "Eggs", quantity: 3, unit: "pcs", category: .protein),
            Ingredient(name: "Turkey", quantity: 80, unit: "g", category: .protein),
            Ingredient(name: "Spinach", quantity: 50, unit: "g", category: .produce)
        ], instructions: "Bake egg muffins with turkey and spinach.", nutrition: "High protein"),
        Recipe(name: "Tuna Pasta", mealType: .lunch, ingredients: [
            Ingredient(name: "Tuna", quantity: 120, unit: "g", category: .protein),
            Ingredient(name: "Pasta", quantity: 90, unit: "g", category: .grains),
            Ingredient(name: "Olive oil", quantity: 10, unit: "ml", category: .pantry)
        ], instructions: "Mix tuna with pasta and olive oil.", nutrition: "Carb support"),
        Recipe(name: "Salmon + Couscous", mealType: .dinner, ingredients: [
            Ingredient(name: "Salmon", quantity: 160, unit: "g", category: .protein),
            Ingredient(name: "Couscous", quantity: 80, unit: "g", category: .grains),
            Ingredient(name: "Broccoli", quantity: 120, unit: "g", category: .produce)
        ], instructions: "Bake salmon, serve with couscous and broccoli.", nutrition: "Omega-3" )
    ]

    private static let fatLoss: [Recipe] = [
        Recipe(name: "Greek Yogurt + Nuts", mealType: .breakfast, ingredients: [
            Ingredient(name: "Greek yogurt", quantity: 180, unit: "g", category: .dairy),
            Ingredient(name: "Strawberries", quantity: 80, unit: "g", category: .produce),
            Ingredient(name: "Almonds", quantity: 15, unit: "g", category: .pantry)
        ], instructions: "Top yogurt with berries and nuts.", nutrition: "Protein + healthy fats"),
        Recipe(name: "Turkey Lettuce Wraps", mealType: .lunch, ingredients: [
            Ingredient(name: "Ground turkey", quantity: 130, unit: "g", category: .protein),
            Ingredient(name: "Lettuce", quantity: 60, unit: "g", category: .produce),
            Ingredient(name: "Bell pepper", quantity: 80, unit: "g", category: .produce)
        ], instructions: "Cook turkey and wrap with lettuce.", nutrition: "Low carb"),
        Recipe(name: "Shrimp + Veggies", mealType: .dinner, ingredients: [
            Ingredient(name: "Shrimp", quantity: 150, unit: "g", category: .protein),
            Ingredient(name: "Zucchini", quantity: 100, unit: "g", category: .produce),
            Ingredient(name: "Mushrooms", quantity: 80, unit: "g", category: .produce)
        ], instructions: "Sauté shrimp with vegetables.", nutrition: "Low calorie"),
        Recipe(name: "Egg White Omelet", mealType: .breakfast, ingredients: [
            Ingredient(name: "Egg whites", quantity: 150, unit: "ml", category: .protein),
            Ingredient(name: "Spinach", quantity: 50, unit: "g", category: .produce),
            Ingredient(name: "Tomato", quantity: 60, unit: "g", category: .produce)
        ], instructions: "Cook egg whites with vegetables.", nutrition: "Lean protein"),
        Recipe(name: "Chicken Veg Bowl", mealType: .lunch, ingredients: [
            Ingredient(name: "Chicken breast", quantity: 130, unit: "g", category: .protein),
            Ingredient(name: "Cauliflower rice", quantity: 150, unit: "g", category: .produce),
            Ingredient(name: "Cucumber", quantity: 60, unit: "g", category: .produce)
        ], instructions: "Serve chicken over cauliflower rice.", nutrition: "Low carb"),
        Recipe(name: "Cod + Greens", mealType: .dinner, ingredients: [
            Ingredient(name: "Cod", quantity: 150, unit: "g", category: .protein),
            Ingredient(name: "Asparagus", quantity: 120, unit: "g", category: .produce),
            Ingredient(name: "Lemon", quantity: 0.5, unit: "piece", category: .produce)
        ], instructions: "Bake cod with lemon and asparagus.", nutrition: "Lean protein" )
    ]

    private static let mediterranean: [Recipe] = [
        Recipe(name: "Greek Yogurt + Honey", mealType: .breakfast, ingredients: [
            Ingredient(name: "Greek yogurt", quantity: 200, unit: "g", category: .dairy),
            Ingredient(name: "Honey", quantity: 10, unit: "g", category: .pantry),
            Ingredient(name: "Walnuts", quantity: 15, unit: "g", category: .pantry)
        ], instructions: "Top yogurt with honey and walnuts.", nutrition: "Healthy fats"),
        Recipe(name: "Mediterranean Salad", mealType: .lunch, ingredients: [
            Ingredient(name: "Tomato", quantity: 100, unit: "g", category: .produce),
            Ingredient(name: "Cucumber", quantity: 80, unit: "g", category: .produce),
            Ingredient(name: "Feta", quantity: 40, unit: "g", category: .dairy)
        ], instructions: "Toss veggies with feta and olive oil.", nutrition: "Fresh & light"),
        Recipe(name: "Olive Oil Fish + Quinoa", mealType: .dinner, ingredients: [
            Ingredient(name: "White fish", quantity: 150, unit: "g", category: .protein),
            Ingredient(name: "Quinoa", quantity: 70, unit: "g", category: .grains),
            Ingredient(name: "Olive oil", quantity: 10, unit: "ml", category: .pantry)
        ], instructions: "Bake fish with olive oil. Serve with quinoa.", nutrition: "Mediterranean"),
        Recipe(name: "Avocado Toast", mealType: .breakfast, ingredients: [
            Ingredient(name: "Whole wheat bread", quantity: 2, unit: "slices", category: .grains),
            Ingredient(name: "Avocado", quantity: 1, unit: "piece", category: .produce),
            Ingredient(name: "Olive oil", quantity: 5, unit: "ml", category: .pantry)
        ], instructions: "Toast bread, top with avocado and olive oil.", nutrition: "Healthy fats"),
        Recipe(name: "Chickpea Salad", mealType: .lunch, ingredients: [
            Ingredient(name: "Chickpeas", quantity: 120, unit: "g", category: .pantry),
            Ingredient(name: "Red onion", quantity: 30, unit: "g", category: .produce),
            Ingredient(name: "Olive oil", quantity: 10, unit: "ml", category: .pantry)
        ], instructions: "Mix chickpeas, onion, olive oil.", nutrition: "Fiber-rich"),
        Recipe(name: "Chicken + Veggies", mealType: .dinner, ingredients: [
            Ingredient(name: "Chicken breast", quantity: 150, unit: "g", category: .protein),
            Ingredient(name: "Zucchini", quantity: 100, unit: "g", category: .produce),
            Ingredient(name: "Bell pepper", quantity: 80, unit: "g", category: .produce)
        ], instructions: "Sauté chicken with veggies.", nutrition: "Lean protein" )
    ]
}
