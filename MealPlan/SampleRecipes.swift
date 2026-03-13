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
        case .chinese:
            return chinese
        case .custom:
            return []
        }
    }


    static func allRecipes() -> [Recipe] {
        balanced + pregnancy + muscleGain + fatLoss + mediterranean + chinese
    }

    private static let balanced: [Recipe] = [
        Recipe(name: "燕麦莓果碗", mealType: .breakfast, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "Oats", quantity: 60, unit: "g", category: .grains),
            Ingredient(name: "Milk", quantity: 200, unit: "ml", category: .dairy),
            Ingredient(name: "Blueberries", quantity: 80, unit: "g", category: .produce)
        ], instructions: "燕麦加牛奶小火煮5–7分钟至浓稠，期间搅拌防粘；出锅后撒上莓果。", nutrition: "Balanced carbs & fiber"),
        Recipe(name: "火鸡三明治", mealType: .lunch, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "Whole wheat bread", quantity: 2, unit: "slices", category: .grains),
            Ingredient(name: "Turkey", quantity: 100, unit: "g", category: .protein),
            Ingredient(name: "Lettuce", quantity: 40, unit: "g", category: .produce)
        ], instructions: "吐司烤香；火鸡片加少许黑胡椒；夹入生菜与火鸡，旁边配一小份绿叶菜。", nutrition: "Lean protein"),
        Recipe(name: "三文鱼配糙米", mealType: .dinner, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "Salmon", quantity: 150, unit: "g", category: .protein),
            Ingredient(name: "Brown rice", quantity: 80, unit: "g", category: .grains),
            Ingredient(name: "Broccoli", quantity: 120, unit: "g", category: .produce)
        ], instructions: "三文鱼抹少许盐胡椒与橄榄油，200°C烤12–15分钟；西兰花蒸3–4分钟；配热米饭。", nutrition: "Omega-3 + fiber"),
        Recipe(name: "希腊酸奶碗", mealType: .breakfast, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "Greek yogurt", quantity: 200, unit: "g", category: .dairy),
            Ingredient(name: "Banana", quantity: 1, unit: "piece", category: .produce),
            Ingredient(name: "Granola", quantity: 40, unit: "g", category: .grains)
        ], instructions: "Spoon yogurt into a bowl, add sliced fruit, then sprinkle granola on top.", nutrition: "Protein + carbs"),
        Recipe(name: "鸡肉沙拉", mealType: .lunch, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "Chicken breast", quantity: 120, unit: "g", category: .protein),
            Ingredient(name: "Mixed greens", quantity: 80, unit: "g", category: .produce),
            Ingredient(name: "Olive oil", quantity: 10, unit: "ml", category: .pantry)
        ], instructions: "鸡胸肉煎/烤至熟透切片；与蔬菜拌匀，少许盐和橄榄油调味。", nutrition: "Light and filling"),
        Recipe(name: "牛肉彩椒快炒", mealType: .dinner, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "Beef", quantity: 140, unit: "g", category: .protein),
            Ingredient(name: "Bell pepper", quantity: 100, unit: "g", category: .produce),
            Ingredient(name: "Rice", quantity: 80, unit: "g", category: .grains)
        ], instructions: "牛肉切片抓少许酱油；彩椒切块；大火快炒牛肉至变色，加入彩椒炒匀，配米饭。", nutrition: "Iron + protein"),
        Recipe(name: "番茄鸡蛋炒饭", nameEn: "Tomato Egg Fried Rice", mealType: .dinner, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "米饭", quantity: 150, unit: "g", category: .grains),
            Ingredient(name: "鸡蛋", quantity: 2, unit: "pcs", category: .protein),
            Ingredient(name: "番茄", quantity: 120, unit: "g", category: .produce)
        ], instructions: "鸡蛋打散下锅炒到凝固盛出；番茄切块下锅炒出汁，加少许盐；倒入米饭翻炒松散，再回锅鸡蛋拌匀，撒葱花。", nutrition: "家常均衡"),
        Recipe(name: "清炒时蔬", nameEn: "Stir-fried Vegetables", mealType: .lunch, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "西兰花", quantity: 120, unit: "g", category: .produce),
            Ingredient(name: "蒜", quantity: 5, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 8, unit: "ml", category: .pantry)
        ], instructions: "蒜末少油小火爆香；下西兰花大火快炒至断生；加少许盐和胡椒，关火出锅。", nutrition: "高纤维"),
        Recipe(name: "小米南瓜粥", nameEn: "Millet Pumpkin Porridge", mealType: .breakfast, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "小米", quantity: 60, unit: "g", category: .grains),
            Ingredient(name: "南瓜", quantity: 100, unit: "g", category: .produce)
        ], instructions: "小米洗净加水煮开，转小火煮20分钟；加入南瓜块再煮10分钟至软糯，可加少许红枣。", nutrition: "暖胃"),
]

    private static let pregnancy: [Recipe] = [
        Recipe(name: "菠菜炒蛋", mealType: .breakfast, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "Eggs", quantity: 2, unit: "pcs", category: .protein),
            Ingredient(name: "Spinach", quantity: 60, unit: "g", category: .produce),
            Ingredient(name: "Cheese", quantity: 20, unit: "g", category: .dairy)
        ], instructions: "鸡蛋打散；菠菜焯水挤干；锅中少油炒蛋，加入菠菜与少量奶酪拌匀。", nutrition: "Folate + protein"),
        Recipe(name: "扁豆汤", mealType: .lunch, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "Lentils", quantity: 120, unit: "g", category: .pantry),
            Ingredient(name: "Carrots", quantity: 80, unit: "g", category: .produce),
            Ingredient(name: "Onion", quantity: 40, unit: "g", category: .produce)
        ], instructions: "扁豆洗净；与胡萝卜洋葱加水小火炖20分钟，调味即可。", nutrition: "Iron + fiber"),
        Recipe(name: "烤鳕鱼配红薯", mealType: .dinner, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "Cod", quantity: 150, unit: "g", category: .protein),
            Ingredient(name: "Sweet potato", quantity: 180, unit: "g", category: .produce),
            Ingredient(name: "Green beans", quantity: 100, unit: "g", category: .produce)
        ], instructions: "红薯切块先烤15分钟；鳕鱼抹盐胡椒同烤12分钟；豆角蒸熟。", nutrition: "Lean protein + vitamin A"),
        Recipe(name: "牛油果吐司", nameEn: "Avocado Toast", mealType: .breakfast, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "Whole wheat bread", quantity: 2, unit: "slices", category: .grains),
            Ingredient(name: "Avocado", quantity: 1, unit: "piece", category: .produce),
            Ingredient(name: "Tomato", quantity: 60, unit: "g", category: .produce)
        ], instructions: "牛油果压泥加少许盐柠檬汁；抹吐司，铺番茄片。", nutrition: "Healthy fats"),
        Recipe(name: "鹰嘴豆碗", mealType: .lunch, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "Chickpeas", quantity: 120, unit: "g", category: .pantry),
            Ingredient(name: "Cucumber", quantity: 80, unit: "g", category: .produce),
            Ingredient(name: "Olive oil", quantity: 10, unit: "ml", category: .pantry)
        ], instructions: "鹰嘴豆冲洗；黄瓜切丁；加橄榄油与少许盐拌匀。", nutrition: "Protein + fiber"),
        Recipe(name: "鸡胸肉配藜麦", mealType: .dinner, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "Chicken breast", quantity: 140, unit: "g", category: .protein),
            Ingredient(name: "Quinoa", quantity: 70, unit: "g", category: .grains),
            Ingredient(name: "Zucchini", quantity: 100, unit: "g", category: .produce)
        ], instructions: "藜麦按1:2水煮12–15分钟；鸡胸肉煎/烤熟切片；西葫芦快炒。", nutrition: "Complete protein"),
        Recipe(name: "猪肝菠菜汤", nameEn: "Pork Liver Spinach Soup", mealType: .lunch, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "猪肝", quantity: 120, unit: "g", category: .protein),
            Ingredient(name: "菠菜", quantity: 80, unit: "g", category: .produce),
            Ingredient(name: "姜", quantity: 5, unit: "g", category: .spices)
        ], instructions: "猪肝切片加料酒抓匀，沸水焯10秒捞出；另起水加姜片煮开，下猪肝与菠菜，沸后调盐和少许胡椒。", nutrition: "补铁"),
        Recipe(name: "红枣枸杞燕麦粥", nameEn: "Jujube Goji Oat Porridge", mealType: .breakfast, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "燕麦", quantity: 60, unit: "g", category: .grains),
            Ingredient(name: "红枣", quantity: 6, unit: "pcs", category: .produce),
            Ingredient(name: "枸杞", quantity: 10, unit: "g", category: .produce)
        ], instructions: "燕麦加水煮10分钟，加入去核红枣与枸杞再煮5分钟，微甜即可。", nutrition: "补气"),
]

    private static let muscleGain: [Recipe] = [
        Recipe(name: "高蛋白燕麦", mealType: .breakfast, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "Oats", quantity: 80, unit: "g", category: .grains),
            Ingredient(name: "Milk", quantity: 250, unit: "ml", category: .dairy),
            Ingredient(name: "Peanut butter", quantity: 20, unit: "g", category: .pantry)
        ], instructions: "燕麦加牛奶煮至黏稠，离火拌入花生酱，可撒少许坚果。", nutrition: "High protein"),
        Recipe(name: "鸡肉能量碗", mealType: .lunch, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "Chicken breast", quantity: 160, unit: "g", category: .protein),
            Ingredient(name: "Rice", quantity: 100, unit: "g", category: .grains),
            Ingredient(name: "Beans", quantity: 80, unit: "g", category: .pantry)
        ], instructions: "鸡胸肉煎/烤熟切块；配米饭与煮豆类。", nutrition: "Protein + carbs"),
        Recipe(name: "牛排配土豆", mealType: .dinner, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "Steak", quantity: 180, unit: "g", category: .protein),
            Ingredient(name: "Potatoes", quantity: 200, unit: "g", category: .produce),
            Ingredient(name: "Asparagus", quantity: 100, unit: "g", category: .produce)
        ], instructions: "牛排煎至喜欢的熟度；土豆切块烤20分钟；芦笋蒸熟。", nutrition: "High protein"),
        Recipe(name: "鸡蛋火鸡杯", mealType: .breakfast, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "Eggs", quantity: 3, unit: "pcs", category: .protein),
            Ingredient(name: "Turkey", quantity: 80, unit: "g", category: .protein),
            Ingredient(name: "Spinach", quantity: 50, unit: "g", category: .produce)
        ], instructions: "鸡蛋打散加入火鸡碎和菠菜；倒入模具；180°C烤15分钟。", nutrition: "High protein"),
        Recipe(name: "金枪鱼意面", mealType: .lunch, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "Tuna", quantity: 120, unit: "g", category: .protein),
            Ingredient(name: "Pasta", quantity: 90, unit: "g", category: .grains),
            Ingredient(name: "Olive oil", quantity: 10, unit: "ml", category: .pantry)
        ], instructions: "意面煮熟；金枪鱼沥干；拌橄榄油和黑胡椒。", nutrition: "Carb support"),
        Recipe(name: "三文鱼配库斯库斯", mealType: .dinner, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "Salmon", quantity: 160, unit: "g", category: .protein),
            Ingredient(name: "Couscous", quantity: 80, unit: "g", category: .grains),
            Ingredient(name: "Broccoli", quantity: 120, unit: "g", category: .produce)
        ], instructions: "三文鱼烤12分钟；库斯库斯按说明冲泡；西兰花蒸熟。", nutrition: "Omega-3"),
        Recipe(name: "鸡胸肉西兰花", nameEn: "Chicken Breast with Broccoli", mealType: .dinner, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "鸡胸肉", quantity: 180, unit: "g", category: .protein),
            Ingredient(name: "西兰花", quantity: 150, unit: "g", category: .produce),
            Ingredient(name: "黑胡椒", quantity: 2, unit: "g", category: .spices)
        ], instructions: "鸡胸肉切厚片少油煎熟撒黑胡椒；西兰花焯水30秒后快炒出锅。", nutrition: "高蛋白"),
        Recipe(name: "牛肉面（清汤）", nameEn: "Beef Noodle Soup", mealType: .lunch, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "牛肉", quantity: 150, unit: "g", category: .protein),
            Ingredient(name: "面条", quantity: 120, unit: "g", category: .grains),
            Ingredient(name: "青菜", quantity: 80, unit: "g", category: .produce)
        ], instructions: "牛肉加姜片煮熟切片；面条煮至弹牙，加入青菜焯熟，浇牛肉清汤即可。", nutrition: "蛋白+碳水"),
]

    private static let fatLoss: [Recipe] = [
        Recipe(name: "希腊酸奶配坚果", mealType: .breakfast, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "Greek yogurt", quantity: 180, unit: "g", category: .dairy),
            Ingredient(name: "Strawberries", quantity: 80, unit: "g", category: .produce),
            Ingredient(name: "Almonds", quantity: 15, unit: "g", category: .pantry)
        ], instructions: "酸奶盛碗，加莓果和坚果。", nutrition: "Protein + healthy fats"),
        Recipe(name: "火鸡生菜卷", mealType: .lunch, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "Ground turkey", quantity: 130, unit: "g", category: .protein),
            Ingredient(name: "Lettuce", quantity: 60, unit: "g", category: .produce),
            Ingredient(name: "Bell pepper", quantity: 80, unit: "g", category: .produce)
        ], instructions: "火鸡炒熟，分装在生菜叶中，配彩椒条。", nutrition: "Low carb"),
        Recipe(name: "虾仁炒时蔬", mealType: .dinner, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "Shrimp", quantity: 150, unit: "g", category: .protein),
            Ingredient(name: "Zucchini", quantity: 100, unit: "g", category: .produce),
            Ingredient(name: "Mushrooms", quantity: 80, unit: "g", category: .produce)
        ], instructions: "虾仁炒变色；加入蔬菜快炒，少许盐。", nutrition: "Low calorie"),
        Recipe(name: "蛋白煎蛋卷", mealType: .breakfast, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "Egg whites", quantity: 150, unit: "ml", category: .protein),
            Ingredient(name: "Spinach", quantity: 50, unit: "g", category: .produce),
            Ingredient(name: "Tomato", quantity: 60, unit: "g", category: .produce)
        ], instructions: "蛋白打散；蔬菜切丁；小火煎熟。", nutrition: "Lean protein"),
        Recipe(name: "鸡肉蔬菜碗", mealType: .lunch, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "Chicken breast", quantity: 130, unit: "g", category: .protein),
            Ingredient(name: "Cauliflower rice", quantity: 150, unit: "g", category: .produce),
            Ingredient(name: "Cucumber", quantity: 60, unit: "g", category: .produce)
        ], instructions: "花椰菜米快炒；鸡肉煎熟切块拌匀。", nutrition: "Low carb"),
        Recipe(name: "鳕鱼配时蔬", mealType: .dinner, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "Cod", quantity: 150, unit: "g", category: .protein),
            Ingredient(name: "Asparagus", quantity: 120, unit: "g", category: .produce),
            Ingredient(name: "Lemon", quantity: 0.5, unit: "piece", category: .produce)
        ], instructions: "鳕鱼抹少许盐和柠檬汁烤12分钟；芦笋蒸熟。", nutrition: "Lean protein"),
        Recipe(name: "冬瓜虾仁", nameEn: "Winter Melon Shrimp", mealType: .dinner, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "冬瓜", quantity: 200, unit: "g", category: .produce),
            Ingredient(name: "虾仁", quantity: 150, unit: "g", category: .protein),
            Ingredient(name: "姜", quantity: 5, unit: "g", category: .spices)
        ], instructions: "姜片少油爆香，下虾仁炒至变色；加入冬瓜片翻炒，加少量水焖5分钟至透明。", nutrition: "低脂"),
        Recipe(name: "凉拌鸡丝", nameEn: "Shredded Chicken Salad", mealType: .lunch, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "鸡胸肉", quantity: 140, unit: "g", category: .protein),
            Ingredient(name: "黄瓜", quantity: 120, unit: "g", category: .produce),
            Ingredient(name: "酱油", quantity: 5, unit: "ml", category: .pantry)
        ], instructions: "鸡胸肉冷水下锅煮熟撕丝；黄瓜切丝；加少许酱油、香油和蒜末拌匀。", nutrition: "低碳"),
]

    private static let mediterranean: [Recipe] = [
        Recipe(name: "希腊酸奶配蜂蜜", nameEn: "Greek Yogurt with Honey", mealType: .breakfast, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "Greek yogurt", quantity: 200, unit: "g", category: .dairy),
            Ingredient(name: "Honey", quantity: 10, unit: "g", category: .pantry),
            Ingredient(name: "Walnuts", quantity: 15, unit: "g", category: .pantry)
        ], instructions: "酸奶加蜂蜜，撒核桃碎。", nutrition: "Healthy fats"),
        Recipe(name: "地中海沙拉", nameEn: "Mediterranean Salad", mealType: .lunch, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "Tomato", quantity: 100, unit: "g", category: .produce),
            Ingredient(name: "Cucumber", quantity: 80, unit: "g", category: .produce),
            Ingredient(name: "Feta", quantity: 40, unit: "g", category: .dairy)
        ], instructions: "番茄黄瓜切块，加菲达与橄榄油拌匀。", nutrition: "Fresh & light"),
        Recipe(name: "橄榄油白鱼配藜麦", nameEn: "Olive Oil Fish with Quinoa", mealType: .dinner, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "White fish", quantity: 150, unit: "g", category: .protein),
            Ingredient(name: "Quinoa", quantity: 70, unit: "g", category: .grains),
            Ingredient(name: "Olive oil", quantity: 10, unit: "ml", category: .pantry)
        ], instructions: "白鱼抹橄榄油烤熟；藜麦煮好装盘。", nutrition: "Mediterranean"),
        Recipe(name: "牛油果吐司", nameEn: "Avocado Toast", mealType: .breakfast, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "Whole wheat bread", quantity: 2, unit: "slices", category: .grains),
            Ingredient(name: "Avocado", quantity: 1, unit: "piece", category: .produce),
            Ingredient(name: "Olive oil", quantity: 5, unit: "ml", category: .pantry)
        ], instructions: "吐司抹牛油果，淋橄榄油，撒少许盐。", nutrition: "Healthy fats"),
        Recipe(name: "鹰嘴豆沙拉", nameEn: "Chickpea Salad", mealType: .lunch, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "Chickpeas", quantity: 120, unit: "g", category: .pantry),
            Ingredient(name: "Red onion", quantity: 30, unit: "g", category: .produce),
            Ingredient(name: "Olive oil", quantity: 10, unit: "ml", category: .pantry)
        ], instructions: "鹰嘴豆沥干；洋葱切细；拌橄榄油和少许盐。", nutrition: "Fiber-rich"),
        Recipe(name: "鸡肉炒蔬菜", nameEn: "Chicken Stir Fry", mealType: .dinner, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "Chicken breast", quantity: 150, unit: "g", category: .protein),
            Ingredient(name: "Zucchini", quantity: 100, unit: "g", category: .produce),
            Ingredient(name: "Bell pepper", quantity: 80, unit: "g", category: .produce)
        ], instructions: "鸡肉切块快炒至变色；加入蔬菜炒熟。", nutrition: "Lean protein"),
        Recipe(name: "橄榄油蒜蓉虾", nameEn: "Garlic Shrimp with Olive Oil", mealType: .dinner, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "虾仁", quantity: 160, unit: "g", category: .protein),
            Ingredient(name: "橄榄油", quantity: 10, unit: "ml", category: .pantry),
            Ingredient(name: "蒜", quantity: 6, unit: "g", category: .spices)
        ], instructions: "蒜蓉用橄榄油小火炒香，放虾仁快速翻炒至变色，加少许盐胡椒。", nutrition: "地中海风味"),
        Recipe(name: "番茄鹰嘴豆炖菜", nameEn: "Tomato Chickpea Stew", mealType: .lunch, ingredients: [
            Ingredient(name: "盐", quantity: 1, unit: "g", category: .spices),
            Ingredient(name: "食用油", quantity: 5, unit: "ml", category: .pantry),
            Ingredient(name: "鹰嘴豆", quantity: 120, unit: "g", category: .pantry),
            Ingredient(name: "番茄", quantity: 150, unit: "g", category: .produce),
            Ingredient(name: "洋葱", quantity: 50, unit: "g", category: .produce)
        ], instructions: "洋葱炒软出香，加入番茄炒出汁，倒入鹰嘴豆小火炖10分钟，调盐。", nutrition: "高纤维"),
]

    private static let chinese: [Recipe] = [
        Recipe(name: "豆浆油条", nameEn: "Soy Milk & Youtiao", mealType: .breakfast, ingredients: [
            Ingredient(name: "豆浆", quantity: 300, unit: "ml", category: .dairy),
            Ingredient(name: "油条", quantity: 1, unit: "根", category: .grains)
        ], instructions: "豆浆加热；油条回烤1–2分钟更酥。", instructionsEn: "Heat soy milk and warm youtiao.", nutrition: "中式早餐", nutritionEn: "Chinese breakfast", prepMinutes: 5, cookMinutes: 3, isSoup: false, cuisine: "家常"),
        Recipe(name: "皮蛋瘦肉粥", nameEn: "Century Egg Pork Congee", mealType: .breakfast, ingredients: [
            Ingredient(name: "大米", quantity: 80, unit: "g", category: .grains),
            Ingredient(name: "皮蛋", quantity: 1, unit: "个", category: .protein),
            Ingredient(name: "瘦肉", quantity: 80, unit: "g", category: .protein)
        ], instructions: "大米加水煮粥30分钟；瘦肉切丝腌制后下锅煮熟，加入皮蛋块再煮5分钟。", instructionsEn: "Simmer rice into congee, add pork and century egg.", nutrition: "暖胃", nutritionEn: "Comforting", prepMinutes: 10, cookMinutes: 35, isSoup: true, cuisine: "家常"),
        Recipe(name: "葱油拌面", nameEn: "Scallion Oil Noodles", mealType: .breakfast, ingredients: [
            Ingredient(name: "面条", quantity: 120, unit: "g", category: .grains),
            Ingredient(name: "葱", quantity: 10, unit: "g", category: .spices),
            Ingredient(name: "酱油", quantity: 10, unit: "ml", category: .spices)
        ], instructions: "葱段小火熬香葱油；面条煮熟拌入葱油和酱油。", instructionsEn: "Cook noodles and toss with scallion oil.", nutrition: "家常", nutritionEn: "Home-style", prepMinutes: 8, cookMinutes: 8, isSoup: false, cuisine: "家常"),
        Recipe(name: "麻婆豆腐", nameEn: "Mapo Tofu", mealType: .lunch, ingredients: [
            Ingredient(name: "豆腐", quantity: 200, unit: "g", category: .protein),
            Ingredient(name: "肉末", quantity: 80, unit: "g", category: .protein),
            Ingredient(name: "豆瓣酱", quantity: 15, unit: "g", category: .spices)
        ], instructions: "豆腐切块焯水1分钟沥干；锅中少油下肉末炒散，加入豆瓣酱炒出红油；加少量清水与生抽，放入豆腐小火煮3分钟；淋水淀粉勾芡，撒花椒粉和葱花。", instructionsEn: "See Chinese steps", nutrition: "川菜经典", nutritionEn: "Sichuan style", cuisine: "川菜"),
        Recipe(name: "酸菜鱼", nameEn: "Sour Fish", mealType: .dinner, ingredients: [
            Ingredient(name: "鱼片", quantity: 200, unit: "g", category: .protein),
            Ingredient(name: "酸菜", quantity: 120, unit: "g", category: .produce),
            Ingredient(name: "泡椒", quantity: 10, unit: "g", category: .spices)
        ], instructions: "酸菜切段炒香，加水煮开并调味；鱼片用盐和淀粉抓匀，下锅滑入至变色；出锅前淋热油和辣椒段增香。", instructionsEn: "See Chinese steps", nutrition: "川味酸辣", nutritionEn: "Sichuan style", cuisine: "川菜"),
        Recipe(name: "剁椒蒸豆腐", nameEn: "Steamed Tofu with Chopped Chiles", mealType: .dinner, ingredients: [
            Ingredient(name: "豆腐", quantity: 200, unit: "g", category: .protein),
            Ingredient(name: "剁椒", quantity: 20, unit: "g", category: .spices),
            Ingredient(name: "葱姜", quantity: 10, unit: "g", category: .spices)
        ], instructions: "豆腐切块铺盘，撒少许盐；铺剁椒和葱姜，上锅蒸8分钟；出锅淋热油与少许生抽。", instructionsEn: "See Chinese steps", nutrition: "湘菜风味", nutritionEn: "Hunan style", cuisine: "湘菜"),
        Recipe(name: "萝卜牛腩汤", nameEn: "Radish Beef Soup", mealType: .dinner, ingredients: [
            Ingredient(name: "牛腩", quantity: 200, unit: "g", category: .protein),
            Ingredient(name: "白萝卜", quantity: 200, unit: "g", category: .produce),
            Ingredient(name: "姜", quantity: 5, unit: "g", category: .spices)
        ], instructions: "牛腩焯水后加姜片炖20分钟；加入萝卜再煮15分钟。", instructionsEn: "See Chinese steps", nutrition: "清润汤品", nutritionEn: "Soup", isSoup: true, cuisine: "家常"),
        Recipe(name: "宫保鸡丁", nameEn: "Kung Pao Chicken", mealType: .lunch, ingredients: [
            Ingredient(name: "鸡胸肉", quantity: 180, unit: "g", category: .protein),
            Ingredient(name: "花生", quantity: 20, unit: "g", category: .pantry),
            Ingredient(name: "干辣椒", quantity: 5, unit: "g", category: .spices)
        ], instructions: "鸡肉切丁，加少许盐、生抽、淀粉抓匀腌10分钟。调一碗料汁：生抽+陈醋+白糖+少量清水。热锅下油爆香干辣椒与花椒，入鸡丁大火快炒至变色，倒入料汁翻炒收浓，最后加入花生翻匀出锅。", instructionsEn: "See Chinese steps", nutrition: "川菜经典", nutritionEn: "Sichuan style", cuisine: "川菜"),
        Recipe(name: "剁椒鱼头", nameEn: "Chopped Chili Fish Head", mealType: .dinner, ingredients: [
            Ingredient(name: "鱼头", quantity: 1, unit: "份", category: .protein),
            Ingredient(name: "剁椒", quantity: 30, unit: "g", category: .spices),
            Ingredient(name: "葱姜", quantity: 10, unit: "g", category: .spices)
        ], instructions: "鱼头洗净擦干，抹盐和料酒腌10分钟；铺上剁椒、葱姜。水开后上锅蒸12–15分钟，出锅淋热油和少许蒸鱼豉油即可。", instructionsEn: "See Chinese steps", nutrition: "湘菜代表", nutritionEn: "Hunan style", cuisine: "湘菜"),
        Recipe(name: "回锅肉", nameEn: "Twice-Cooked Pork", mealType: .dinner, ingredients: [
            Ingredient(name: "五花肉", quantity: 200, unit: "g", category: .protein),
            Ingredient(name: "青蒜", quantity: 80, unit: "g", category: .produce),
            Ingredient(name: "豆瓣酱", quantity: 15, unit: "g", category: .spices)
        ], instructions: "五花肉冷水下锅加姜片煮至八成熟，捞出放凉切薄片。热锅少油下豆瓣酱炒出红油，放蒜片与青蒜梗炒香，入肉片翻炒卷曲，最后下青蒜叶快速翻匀，淋少许生抽出锅。", instructionsEn: "See Chinese steps", nutrition: "川菜家常", nutritionEn: "Sichuan style", cuisine: "川菜"),
        Recipe(name: "小炒黄牛肉", nameEn: "Stir-fried Beef with Chiles", mealType: .lunch, ingredients: [
            Ingredient(name: "牛肉", quantity: 180, unit: "g", category: .protein),
            Ingredient(name: "尖椒", quantity: 100, unit: "g", category: .produce),
            Ingredient(name: "豆豉", quantity: 5, unit: "g", category: .spices)
        ], instructions: "牛肉逆纹切片，加生抽、少许淀粉腌10分钟。大火热锅下油，牛肉快速滑炒至变色盛出；锅中余油下豆豉与尖椒炒香，回锅牛肉翻匀，少许盐调味。", instructionsEn: "See Chinese steps", nutrition: "湘菜风味", nutritionEn: "Hunan style", cuisine: "湘菜"),
        Recipe(name: "紫菜蛋花汤", nameEn: "Seaweed Egg Drop Soup", mealType: .dinner, ingredients: [
            Ingredient(name: "紫菜", quantity: 5, unit: "g", category: .pantry),
            Ingredient(name: "鸡蛋", quantity: 1, unit: "pcs", category: .protein),
            Ingredient(name: "香葱", quantity: 5, unit: "g", category: .spices)
        ], instructions: "水开下紫菜煮1分钟；鸡蛋打散沿锅边缓慢淋入成蛋花；加盐与葱花即可。", instructionsEn: "See Chinese steps", nutrition: "清淡汤品", nutritionEn: "Light soup", cuisine: "家常"),
        Recipe(name: "酸辣汤", nameEn: "Hot and Sour Soup", mealType: .lunch, ingredients: [
            Ingredient(name: "木耳", quantity: 10, unit: "g", category: .produce),
            Ingredient(name: "豆腐", quantity: 80, unit: "g", category: .protein),
            Ingredient(name: "醋", quantity: 10, unit: "ml", category: .spices)
        ], instructions: "木耳泡发切丝，豆腐切条。锅中加水煮开，下木耳与豆腐煮3分钟；加入酱油、白醋、白胡椒调味，淋入蛋液成蛋花，最后加香油与葱花。", instructionsEn: "See Chinese steps", nutrition: "开胃", nutritionEn: "Appetizing", cuisine: "家常"),
        Recipe(name: "冬瓜排骨汤", nameEn: "Winter Melon Pork Rib Soup", mealType: .dinner, ingredients: [
            Ingredient(name: "排骨", quantity: 200, unit: "g", category: .protein),
            Ingredient(name: "冬瓜", quantity: 200, unit: "g", category: .produce),
            Ingredient(name: "姜", quantity: 5, unit: "g", category: .spices)
        ], instructions: "排骨冷水下锅焯水去血沫；另起锅加姜片炖20分钟。加入冬瓜块再煮10–15分钟至透明，调盐即可。", instructionsEn: "See Chinese steps", nutrition: "清润", nutritionEn: "Light broth", cuisine: "家常"),
        Recipe(name: "番茄炒蛋", nameEn: "Tomato Egg Stir-fry", mealType: .dinner, ingredients: [
            Ingredient(name: "鸡蛋", quantity: 2, unit: "pcs", category: .protein),
            Ingredient(name: "番茄", quantity: 150, unit: "g", category: .produce),
            Ingredient(name: "葱", quantity: 5, unit: "g", category: .spices)
        ], instructions: "鸡蛋打散炒到凝固盛出；番茄切块炒出汁，回锅鸡蛋翻匀，撒葱花与少许糖提鲜。", instructionsEn: "See Chinese steps", nutrition: "家常", nutritionEn: "Home-style", cuisine: "家常")
    ]
}
