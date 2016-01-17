Capstone Text Prediction App
========================================================
author: JoeBooksLevy
date: January 23, 2015

Background Context
========================================================

- Lots of people take advantage of technology for text prediction. Most common to folks is text prediction for cell phone applications with messaging. Data scientists may use natural language processing and prediction algorithm skills for greater data applications.
- For the Coursera Data Science Capstone, Swiftkey provided sample US news, blogs, and Twitter data to utilize for students to build an application. I used this data set to build a simple text prediction application.
- While a simple application, the process and application serve as an example to build off of for larger applications or data implications.

My Process 
========================================================

- First, I downloaded, cleaned, and explored the data set.
- I then looked for the most common single-word, two-word, and three-word phrases from the data sets, creating n-grams.
- I used the n-grams as the foundation for the prediction algorithm. As a two-word phrase is entered in the application, 
it is checked against most common three-word phrases to predict the third associated word. If no matches are found, the 

My Application (Access and How It Works)
========================================================

- My ShinyApp can be found here: 
- As a two-word phrase is entered in the application, the input is cleaned and prepared to be best searched against the n-gram data sets (e.g., removing punctuation, making text all lower case).
- Once cleaned, the phrase is checked against most common three-word phrases to predict the third associated word. 
- If no matches are found, the phrase is checked against two-word phrases and one-word phrases, looking at likelihood of terms/words for best match.
- The result based on the entered phrase is the best matched/predicted next word. Where exact matches do not occur, up to three words likely to be next in sequence are provided.

Limitations and Possibilities for App
========================================================

- One limitation is that the application's load time and initial functioning takes longer than it should and sometimes give memory errors. This is likely due to code and process not being as efficient as it could be.
- A second limitation is the lack of accuracy. Even Swiftkey - a leading company specializing on text prediction - is not perfect, so my initial attempt at an algorithm is limited in scope and may not always meet the need of inputs.
- Given these limitations, there is ample possibility for enhancement of the application for its given purpose. Moreover, implications and more advanced applications of the logic here could help predict behavior or better analyze text for other data needs.