from PIL import Image
import pytesseract

# Path to the image file
image_path = './recipes/black-bean-quesadilla-v2.jpg'

# Open the image file
img = Image.open(image_path)

# Some image modes (like CMYK or LAB) might not be supported directly by Tesseract.
# Ensure the image is in a compatible mode, such as RGB
img = img.convert('RGB')

# Path to the Tesseract executable
pytesseract.pytesseract.tesseract_cmd = r'C:\\Program Files\\Tesseract-OCR\\tesseract.exe'

# Use pytesseract to do OCR on the image
text = pytesseract.image_to_string(img)

# Print the extracted text
print(text)

# Printed output:
# When | was a

# resta

# BLACK BEAN AND GOAT
# CHEESE QUESADILLAS

# kid, my picky palate usually resulted in me ordering plain cheese Quesa
# id,
# +s. | still like my quesadillas to be creamy, but now | also want some texture,
# nts.
# : mife tion in flavor. With two types of cheese, spiced black beans, and a tangy sou
# ana varia :

# SERVES 2

# Spice

# F Cream

# d Greek yogurt sauce, these quesadillas are hearty, cheesy, and totally comforting.
# an $5 !

# INGREDIENTS:

# 1 cup no-salt-added black beans,
# drained and rinsed

# Ya—V2 teaspoon fine sea salt (or to taste),
# divided

# %e-Y% teaspoon crushed red pepper,
# divided

# Ye cup fresh cilantro, chopped, divided
# Ye cup 2% plain Greek yogurt

# 2 tablespoons sour cream

# ‘4 teaspoon onion powder

# % teaspoon garlic powder

# 2 whole wheat tortillas

# 2 ounces goat cheese

# ounce Fontina cheese, shredded (Y%4
# Cup)

# teaspoons olive oil, divided

# ORMATION PER SERVING:
# Ones from Fat 210, Fat
# g) 12.5. Protein (g) 29.4

# (9) 47.4, Dietary c,
# ‘ y Fibe
# mg) 57, Sodium (mg) pay! 7.6,

# calories 515, Cay
# Saturated Fat (
# Carbohydrate
# Cholestero| (

# (g) 23.3,

# INSTRUCTIONS:

# tf,

# In a large bowl, lightly mash the black beans with
# a fork and then stir in half the salt, crushed red
# pepper, and cilantro. Set aside.

# In another bowl, combine the Greek yogurt,
# sour cream, onion powder, garlic powder, and
# remaining salt.

# spoon half of the Greek yogurt mixture on one
# tortilla. Spoon half the black bean mixture on half
# of the tortilla, and sprinkle with half of the goat
# cheese and Fontina cheese. Fold the tortilla over
# and press down. Repeat with the other tortilla ano
# remaining ingredients.

# Heat % teaspoon of the olive oil in a nonstick
# skillet. Place a tortilla in the skillet. After

# 2 to 3 minutes, lift the quesadilla, add ee
# %2 teaspoon of olive oil, and cook the other s!
# of the quesadilla until golden brown. Repeat
# with the remaining tortilla and oil.

# Top with cilantro, salsa, or sour cream.

### Text copied from Android (MUCH better):

# BLACK BEAN AND GOAT CHEESE QUESADILLAS

# SERVES 2

# When I was a kid, my picky palate usually resulted in me ordering plain cheese quesadillas at restaurants. I stillike my quesadillas to be creamy, but now I also want some texture, spice, and variation in flavor. With two types of cheese, spiced black beans, and a tangy sour cream and Greek yogurt sauce, these quesadillas are hearty, cheesy, and totally comforting.

# INGREDIENTS:

# 1 cup no-salt-added black beans, drained and rinsed

# 1½-½ teaspoon fine sea salt (or to taste), divided

# V-½ teaspoon crushed red pepper, divided

# 1½ cup fresh cilantro, chopped, divided

# 1½ cup 2% plain Greek yogurt

# 2 tablespoons sour cream

# ½ teaspoon onion powder

# 1½ teaspoon garlic powder

# 2 whole wheat tortillas

# 2 ounces goat cheese

# 1 ounce Fontina cheese, shredded (14 cup)

# 2 teaspoons olive oil, divided

# INSTRUCTIONS:

# 1. In a large bowl, lightly mash the black beans with a fork and then stir in half the salt, crushed red pepper, and cilantro. Set aside.

# 2. In another bowl, combine the Greek yogurt, sour cream, onion powder, garlic powder, and remaining salt.

# 3. Spoon half of the Greek yogurt mixture on one tortilla. Spoon half the black bean mixture on half of the tortilla, and sprinkle with half of the goat cheese and Fontina cheese. Fold the tortilla over and press down. Repeat with the other tortilla and remaining ingredients.

# 4. Heat 1½ teaspoon of the olive oil in a nonstick skillet. Place a tortilla in the skillet. After 2 to 3 minutes, lift the quesadilla, add another 1½ teaspoon of olive oil, and cook the other side of the quesadilla until golden brown. Repeat with the remaining tortilla and oil.

# 5. Top with cilantro, salsa, or sour cream.

# NUTRITION INFORMATION PER SERVING:

# Calories 515, Calories from Fat 210, Fat (g) 23.3,

# Saturated Fat (g) 12.5, Protein (g) 29.4, Carbohydrate (g) 47.4, Dietary Fiber (g) 7.6, Cholesterol (mg) 57, Sodium (mg) 676