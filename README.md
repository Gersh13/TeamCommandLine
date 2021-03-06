# Team Command Line Parser Project


### Project Explanation

Implemented a parser for Python language by using Context-free Grammar (CFG) with ANTLR. We created a Python interpreter using Java and ANTLR. ANTLR generates a parser that builds and walk parse trees from grammer. This is not a complete parser and will only include basic features. Expected Features: if/else blocks, variable definitions, while and for loops, Arithmetic operators, assignment operators, and conditional statements. 

### Team Members & GitHub Alias

- Evan Gerstner     - Gersh13
- Ali Shahmoradi    - asrn9
- Jim Yang          - jydz9
- Michael Boeding   - michaelboeding

### Prerequisites to run

1. ANTLR - Our team used ANTLR as it was reccommended in the project description and we found it to be the best of the other options when it came to documentation.
2. IntelliJ - IntelliJ is the IDE we chose to run this.



### Neccessary steps for setting up (Feel free to skip a step if anything is already installed)
1. Download [IntelliJ](https://www.jetbrains.com/idea/download/)
2. Download this repository (Just as a zip and go ahead and open/unzip the contents)
3. Download the ANTLR jar: https://www.antlr.org/download/antlr-4.9-complete.jar (Press to download)
4. We need to install the [Java SE Development Kit](https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html). This will be used as our JDK.


### Getting the code ready to run (Assuming no experience with IntelliJ)
1. Open IntelliJ and create a new project. You will need to select Java (which will be on the left side). For the 'Project JDK' this is where we will want to make sure we use the JDK 1.8 that we grabbed from step 3 on the last section. The project can be named whatever and placed wherever, and then finish by creating it. 
2. Next we need to add the ANTLR plugin. Press the "IntelliJ IDEA" at the top left and go down to preferences and select it, and then plugins on the new pop up window.
4. Search "ANTLR v4 Plugin" and install it. Once installed we can close out of the pop up.
5. Now we need to drag the unzipped repo (use your finder) into the location of where this project was made.
6. Go back to IntelliJ and go to the project folder. If it hasn't updated you can refresh by right cicking and pressing reload from disk.
7. Right click onto our grammarForPython.g4 file, select "Configure ANTLR". Click on the input field for the "Output directory where all output is generated" and input "src". You can close out now of the antlter pop up.
8. Now price file at the top bar of IntelliJ, go to project structure, then on the pop up select modules.
9. Select the plus sign and then Jars or Directories, and when the explorer opens you just have to grab the antlr jar that you downloaded earlier. Apply this then close out.


### Running our code
1. If the puthon_test_code.py is correct, you can right click our grammarForPython.g4 file and sekect the "Generate ANTLR Recognizer: and it will generate all of the lexer and parser files. 
2. You run by right clicking on our mainStart.java file and clicking "Run mainStart.main()"


We got the .g4 file working but couldnt get eveything to link correctly. 
Spent a ton of time on it but couldnt figure it out, Please go easy on us. Checking the G4 seems like everything is there.
