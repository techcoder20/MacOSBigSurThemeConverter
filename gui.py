from tkinter import *
import tkinter.font as font
from PIL import ImageTk,Image
import os
root = Tk()
root.title("MacOSBigSurThemeConverter")

#Iniitialing Functions
def MacOSBigSurLight():
    os.system("bash ~/.local/share/MacOSBigSurThemeConverter/MacOSBigSurLight.sh")

def MacOSBigSurDark():
    os.system("bash ~/.local/share/MacOSBigSurThemeConverter/MacOSBigSurDark.sh")

def uninstall():
    os.system("bash ~/.local/share/MacOSBigSurThemeConverter/uninstall.sh")

#Defining Font
myFont = font.Font(family='Helvetica')
#Defining Images
MacOSBigSurLightScreenshot = ImageTk.PhotoImage(Image.open("/home/pi/.local/share/MacOSBigSurThemeConverter/assets/gui/MacOSBigSurLightScreenshot.png"))
MacOSBigSurDarkScreenshot = ImageTk.PhotoImage(Image.open("/home/pi/.local/share/MacOSBigSurThemeConverter/assets/gui/MacOSBigSurDarkScreenshot.png"))
MacOSBigSurThemeConverter = ImageTk.PhotoImage(Image.open("/home/pi/.local/share/MacOSBigSurThemeConverter/assets/gui/MacOSBigSurThemeConverter.png"))
#Creating Labels For Images
MacOSBigSurLightScreenshotLabel = Label(image=MacOSBigSurLightScreenshot)
MacOSBigSurDarkScreenshotLabel = Label(image=MacOSBigSurDarkScreenshot)
MacOSBigSurThemeConverterLabel = Label(image=MacOSBigSurThemeConverter)
#Initialising buttons
MacOSBigSurLightButton = Button(text="Convert To MacOSBigSurLight", command=MacOSBigSurLight, bg="white", fg="black", font=myFont, bd=2)
MacOSBigSurDarkButton = Button(text="Convert To MacOSBigSurDark", command=MacOSBigSurDark, bg="white", fg="black", font=myFont, bd=2)

Label1 = Label(text="Which Theme Do You Want ?")

#Placing widgets on screen
MacOSBigSurThemeConverterLabel.grid (row=0, column=1, columnspan=3, pady=5)
Label1.grid(row=1, column=1)
MacOSBigSurLightScreenshotLabel.grid(row=2, column=1, columnspan=3, pady=5)
MacOSBigSurLightButton.grid(row=3, column=1, padx=80)
MacOSBigSurDarkScreenshotLabel.grid(row=4, column=1, columnspan=3, pady=5)
MacOSBigSurDarkButton.grid(row=5, column=1, padx=80)

# Creating a tuple containing  
# the specifications of the font. 
Font_tuple = ("Monospace", 15) 
  
# Parsed the specifications to the 
# Text widget using .configure( ) method. 
Label1.configure(font = Font_tuple)


root.mainloop()
