DROP SCHEMA IF EXISTS meal_planner CASCADE;

CREATE SCHEMA IF NOT EXISTS meal_planner;

CREATE TABLE IF NOT EXISTS meal_planner.source (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS meal_planner.meal (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS meal_planner.recipe (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    source_id INT NOT NULL,
    page_number INT,
    servings_min INT,
    servings_max INT,
    servings_unit TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (source_id) REFERENCES meal_planner.source(id)
);

CREATE TABLE IF NOT EXISTS meal_planner.meal_recipe (
    id SERIAL PRIMARY KEY,
    meal_id INT NOT NULL,
    recipe_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (meal_id) REFERENCES meal_planner.meal(id),
    FOREIGN KEY (recipe_id) REFERENCES meal_planner.recipe(id)
);

CREATE TABLE IF NOT EXISTS meal_planner.recipe_ingredient_group (
    id SERIAL PRIMARY KEY,
    recipe_id INT NOT NULL,
    description TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (recipe_id) REFERENCES meal_planner.recipe(id)
);

CREATE TABLE IF NOT EXISTS meal_planner.ingredient (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS meal_planner.recipe_ingredient (
    id SERIAL PRIMARY KEY,
    recipe_id INT,
    recipe_ingredient_group_id INT,
    ingredient_id INT,
    ingredient_recipe_id INT,
    quantity REAL,
    quantity_description TEXT,
    unit TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (recipe_id) REFERENCES meal_planner.recipe(id),
    FOREIGN KEY (recipe_ingredient_group_id) REFERENCES meal_planner.recipe_ingredient_group(id),
    FOREIGN KEY (ingredient_id) REFERENCES meal_planner.ingredient(id),
    FOREIGN KEY (ingredient_recipe_id) REFERENCES meal_planner.recipe(id)
);

DO $$
DECLARE source_joy_of_cooking INTEGER;

DECLARE meal_dinner INTEGER;

DECLARE recipe_cooked_octopus INTEGER;
DECLARE recipe_cooked_short_grain_rice INTEGER;
DECLARE recipe_tako_poke INTEGER;
DECLARE recipe_south_carolina_style_mustard_barbecue_sauce INTEGER;
DECLARE recipe_smothered_country_style_ribs INTEGER;

DECLARE ingredient_group_tako_poke_tamari_or_soy_sauce INTEGER;
DECLARE ingredient_group_tako_poke_green_onion_or_sweet_onion INTEGER;
DECLARE ingredient_group_smothered_country_style_ribs_barbecue_sauce INTEGER;

DECLARE ingredient_bay_leaf INTEGER;
DECLARE ingredient_black_pepper INTEGER;
DECLARE ingredient_black_peppercorn INTEGER;
DECLARE ingredient_butter INTEGER;
DECLARE ingredient_cider_vinegar INTEGER;
DECLARE ingredient_country_style_ribs INTEGER;
DECLARE ingredient_garlic_clove INTEGER;
DECLARE ingredient_garlic_powder INTEGER;
DECLARE ingredient_gochujang INTEGER;
DECLARE ingredient_green_onion INTEGER;
DECLARE ingredient_ketchup INTEGER;
DECLARE ingredient_kimchi INTEGER;
DECLARE ingredient_octopus INTEGER;
DECLARE ingredient_onion_powder INTEGER;
DECLARE ingredient_salt INTEGER;
DECLARE ingredient_sesame_oil INTEGER;
DECLARE ingredient_toasted_sesame_seed INTEGER;
DECLARE ingredient_short_grain_rice INTEGER;
DECLARE ingredient_soy_sauce INTEGER;
DECLARE ingredient_sugar INTEGER;
DECLARE ingredient_sweet_onion INTEGER;
DECLARE ingredient_tamari INTEGER;
DECLARE ingredient_water INTEGER;
DECLARE ingredient_worcestershire_sauce INTEGER;
DECLARE ingredient_yellow_mustard INTEGER;

BEGIN
    -- Sources
    INSERT INTO meal_planner.source (name) VALUES
        ('Joy of Cooking: A New Generation of Joy')
    ;

    SELECT id INTO source_joy_of_cooking FROM meal_planner.source WHERE name = 'Joy of Cooking: A New Generation of Joy';

    -- Meals
    INSERT INTO meal_planner.meal (name) VALUES
        ('Breakfast'),
        ('Lunch'),
        ('Dinner'),
        ('Snack'),
        ('Dessert'),
        ('Drink')
    ;

    SELECT id INTO meal_dinner FROM meal_planner.meal WHERE name = 'Dinner';

    -- Recipes
    INSERT INTO meal_planner.recipe (name, source_id, page_number, servings_min, servings_max, servings_unit) VALUES
        ('Cooked Octopus', source_joy_of_cooking, 368, NULL, NULL, NULL),
        ('Cooked Short Grain Rice', source_joy_of_cooking, 343, 2, 3, NULL),
        ('Tako Poke (Korean-Style Octopus Poke)', source_joy_of_cooking, 369, 4, 4, NULL),
        ('South Carolina-Style Mustard Barbecue Sauce', source_joy_of_cooking, 583, 3, 3, 'cup'),
        ('Smothered Country-Style Ribs', source_joy_of_cooking, 496, 6, 8, NULL)
    ;

    SELECT id INTO recipe_cooked_octopus FROM meal_planner.recipe WHERE name = 'Cooked Octopus';
    SELECT id INTO recipe_cooked_short_grain_rice FROM meal_planner.recipe WHERE name = 'Cooked Short Grain Rice';
    SELECT id INTO recipe_tako_poke FROM meal_planner.recipe WHERE name = 'Tako Poke (Korean-Style Octopus Poke)';
    SELECT id INTO recipe_south_carolina_style_mustard_barbecue_sauce FROM meal_planner.recipe WHERE name = 'South Carolina-Style Mustard Barbecue Sauce';
    SELECT id INTO recipe_smothered_country_style_ribs FROM meal_planner.recipe WHERE name = 'Smothered Country-Style Ribs';

    -- Meal Recipes
    INSERT INTO meal_planner.meal_recipe (meal_id, recipe_id) VALUES
        (meal_dinner, recipe_smothered_country_style_ribs),
        (meal_dinner, recipe_tako_poke)
    ;

    -- Recipe Ingredient Groups
    INSERT INTO meal_planner.recipe_ingredient_group (recipe_id, description) VALUES
        (recipe_tako_poke, 'tamari or soy sauce'),
        (recipe_tako_poke, 'green onion or sweet onion'),
        (recipe_smothered_country_style_ribs, 'barbecue sauce')
    ;

    SELECT id INTO ingredient_group_tako_poke_tamari_or_soy_sauce FROM meal_planner.recipe_ingredient_group WHERE recipe_id = recipe_tako_poke AND description = 'tamari or soy sauce';
    SELECT id INTO ingredient_group_tako_poke_green_onion_or_sweet_onion FROM meal_planner.recipe_ingredient_group WHERE recipe_id = recipe_tako_poke AND description = 'green onion or sweet onion';
    SELECT id INTO ingredient_group_smothered_country_style_ribs_barbecue_sauce FROM meal_planner.recipe_ingredient_group WHERE recipe_id = recipe_smothered_country_style_ribs AND description = 'barbecue sauce';

    -- Ingredients
    INSERT INTO meal_planner.ingredient (name) VALUES
        ('bay leaf'),
        ('black pepper'),
        ('black peppercorn'),
        ('butter'),
        ('cider vinegar'),
        ('country-style ribs'),
        ('garlic clove'),
        ('garlic powder'),
        ('gochujang'),
        ('green onion'),
        ('ketchup'),
        ('kimchi'),
        ('octopus'),
        ('onion powder'),
        ('salt'),
        ('sesame oil'),
        ('sugar'),
        ('toasted sesame seed'),
        ('short grain rice'),
        ('soy sauce'),
        ('sweet onion'),
        ('tamari'),
        ('water'),
        ('Worcestershire sauce'),
        ('yellow mustard')
    ;

    SELECT id INTO ingredient_bay_leaf FROM meal_planner.ingredient WHERE name = 'bay leaf';
    SELECT id INTO ingredient_black_pepper FROM meal_planner.ingredient WHERE name = 'black pepper';
    SELECT id INTO ingredient_black_peppercorn FROM meal_planner.ingredient WHERE name = 'black peppercorn';
    SELECT id INTO ingredient_butter FROM meal_planner.ingredient WHERE name = 'butter';
    SELECT id INTO ingredient_cider_vinegar FROM meal_planner.ingredient WHERE name = 'cider vinegar';
    SELECT id INTO ingredient_country_style_ribs FROM meal_planner.ingredient WHERE name = 'country-style ribs';
    SELECT id INTO ingredient_garlic_clove FROM meal_planner.ingredient WHERE name = 'garlic clove';
    SELECT id INTO ingredient_garlic_powder FROM meal_planner.ingredient WHERE name = 'garlic powder';
    SELECT id INTO ingredient_gochujang FROM meal_planner.ingredient WHERE name = 'gochujang';
    SELECT id INTO ingredient_green_onion FROM meal_planner.ingredient WHERE name = 'green onion';
    SELECT id INTO ingredient_ketchup FROM meal_planner.ingredient WHERE name = 'ketchup';
    SELECT id INTO ingredient_kimchi FROM meal_planner.ingredient WHERE name = 'kimchi';
    SELECT id INTO ingredient_octopus FROM meal_planner.ingredient WHERE name = 'octopus';
    SELECT id INTO ingredient_onion_powder FROM meal_planner.ingredient WHERE name = 'onion powder';
    SELECT id INTO ingredient_salt FROM meal_planner.ingredient WHERE name = 'salt';
    SELECT id INTO ingredient_sesame_oil FROM meal_planner.ingredient WHERE name = 'sesame oil';
    SELECT id INTO ingredient_sugar FROM meal_planner.ingredient WHERE name = 'sugar';
    SELECT id INTO ingredient_toasted_sesame_seed FROM meal_planner.ingredient WHERE name = 'toasted sesame seed';
    SELECT id INTO ingredient_short_grain_rice FROM meal_planner.ingredient WHERE name = 'short grain rice';
    SELECT id INTO ingredient_soy_sauce FROM meal_planner.ingredient WHERE name = 'soy sauce';
    SELECT id INTO ingredient_sweet_onion FROM meal_planner.ingredient WHERE name = 'sweet onion';
    SELECT id INTO ingredient_tamari FROM meal_planner.ingredient WHERE name = 'tamari';
    SELECT id INTO ingredient_yellow_mustard FROM meal_planner.ingredient WHERE name = 'yellow mustard';
    SELECT id INTO ingredient_water FROM meal_planner.ingredient WHERE name = 'water';
    SELECT id INTO ingredient_worcestershire_sauce FROM meal_planner.ingredient WHERE name = 'Worcestershire sauce';

    -- Recipe Ingredients
    INSERT INTO meal_planner.recipe_ingredient (recipe_id, recipe_ingredient_group_id, ingredient_id, ingredient_recipe_id, quantity, unit, quantity_description) VALUES
        (recipe_cooked_octopus, NULL, ingredient_octopus, NULL, 1, NULL, NULL),
        (recipe_cooked_octopus, NULL, ingredient_salt, NULL, 1, 'tbsp', NULL),
        (recipe_cooked_octopus, NULL, ingredient_bay_leaf, NULL, 1, NULL, NULL),
        (recipe_cooked_octopus, NULL, ingredient_garlic_clove, NULL, 2, NULL, NULL),
        (recipe_cooked_octopus, NULL, ingredient_black_peppercorn, NULL, NULL, NULL, 'few'),
        (NULL, ingredient_group_tako_poke_tamari_or_soy_sauce, ingredient_tamari, NULL, 3, 'tbsp', NULL),
        (NULL, ingredient_group_tako_poke_tamari_or_soy_sauce, ingredient_soy_sauce, NULL, 3, 'tbsp', NULL),
        (NULL, ingredient_group_tako_poke_green_onion_or_sweet_onion, ingredient_green_onion, NULL, 2, NULL, NULL),
        (NULL, ingredient_group_tako_poke_green_onion_or_sweet_onion, ingredient_sweet_onion, NULL, 0.25, 'cup', NULL),
        (recipe_cooked_short_grain_rice, NULL, ingredient_short_grain_rice, NULL, 1, 'cup', NULL),
        (recipe_cooked_short_grain_rice, NULL, ingredient_salt, NULL, 0.5, 'tsp', NULL),
        (recipe_cooked_short_grain_rice, NULL, ingredient_butter, NULL, 2, 'tbsp', NULL),
        (recipe_tako_poke, NULL, NULL, recipe_cooked_octopus, 1, NULL, NULL),
        (recipe_tako_poke, NULL, ingredient_gochujang, NULL, 1, 'tbsp', NULL),
        (recipe_tako_poke, NULL, ingredient_sesame_oil, NULL, 1, 'tbsp', NULL),
        (recipe_tako_poke, NULL, ingredient_kimchi, NULL, 0.5, 'cup', NULL),
        (recipe_tako_poke, NULL, ingredient_toasted_sesame_seed, NULL, 1, 'tsp', NULL),
        (recipe_tako_poke, NULL, NULL, recipe_cooked_short_grain_rice, NULL, NULL, NULL),
        (recipe_south_carolina_style_mustard_barbecue_sauce, NULL, ingredient_yellow_mustard, NULL, 1.5, 'cup', NULL),
        (recipe_south_carolina_style_mustard_barbecue_sauce, NULL, ingredient_ketchup, NULL, 0.5, 'cup', NULL),
        (recipe_south_carolina_style_mustard_barbecue_sauce, NULL, ingredient_cider_vinegar, NULL, 0.5, 'cup', NULL),
        (recipe_south_carolina_style_mustard_barbecue_sauce, NULL, ingredient_sugar, NULL, 0.5, 'cup', NULL),
        (recipe_south_carolina_style_mustard_barbecue_sauce, NULL, ingredient_worcestershire_sauce, NULL, 2, 'tbsp', NULL),
        (recipe_south_carolina_style_mustard_barbecue_sauce, NULL, ingredient_black_pepper, NULL, 1, 'tbsp', NULL),
        (recipe_south_carolina_style_mustard_barbecue_sauce, NULL, ingredient_garlic_powder, NULL, 2, 'tsp', NULL),
        (recipe_south_carolina_style_mustard_barbecue_sauce, NULL, ingredient_onion_powder, NULL, 2, 'tsp', NULL),
        (recipe_smothered_country_style_ribs, NULL, ingredient_country_style_ribs, NULL, 4, 'lb', NULL),
        (NULL, ingredient_group_smothered_country_style_ribs_barbecue_sauce, NULL, recipe_south_carolina_style_mustard_barbecue_sauce, 1.5, 'cup', NULL),
        (recipe_smothered_country_style_ribs, NULL, ingredient_water, NULL, 1, 'cup', NULL)
    ;
END $$;
