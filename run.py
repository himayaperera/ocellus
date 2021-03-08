# Import the required module for text  
# to speech conversion 
from gtts import gTTS 
  
# This module is imported so that we can  
# play the converted audio 
import os 
  
# The text that you want to convert to audio 
mytext = 'hi everyone this is a formal announcement to declare that himaya is a genius and she figured out the text to speech api by herself also wanted to say kavishka sucks'
  
mytext2= 'you sucketh more'


# Language in which you want to convert 
language = 'en'
  
# Passing the text and language to the engine,  
# here we have marked slow=False. Which tells  
# the module that the converted audio should  
# have a high speed 
myobj = gTTS(text=mytext, lang=language, slow=False) 
myobj2= gTTS(text=mytext2, lang=language, slow=False)
  
# Saving the converted audio in a mp3 file named 
# welcome  
myobj.save("welcome.mp3") 
myobj2.save("two.mp3")
  
# Playing the converted file 
os.system("mpg321 two.mp3") 
#os.system("mpg321 two.mp3")