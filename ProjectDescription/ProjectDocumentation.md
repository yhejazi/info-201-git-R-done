# Project Description ![](http://screenwerk.com/wpn/media/Screen-Shot-2013-02-19-at-7.06.02-AM.png)

#### **Created by:** Andrea Jorge, Yasmine Hejazi, Julia Zaratan, Katie Breland, and Kuo Hong  

##### See our work on [GitHub!] (https://github.com/yhejazi/info-201-git-R-done)   

### What is Yelp?
Yelp is an online application that connects customers to local businesses by allowing them to write reviews and give ratings. Yelp's Chief Executive Officer and Co-founder, [Jeremy Stoppelman](https://www.yelpblog.com/2013/01/introducing-lives), describes Yelp's mission as a way to:

> "...connect people with great local businesses; along the way, we hope to enrich lives of consumers and small business owners. In pursuit of this mission, we want to provide the most helpful information possible about local businesses. While ratings and reviews are incredibly powerful ways to guide spending decisions, we’re always looking for new ways to supplement the information to provide a better experience for consumers"

### What is the Data?
All the data that we worked with in our project can be found at:
https://www.yelp.com/developers/documentation/v3

The data was gathered by [Yelp](https://www.yelp.com/sf) which was founded in 2004 as a way to connect people with local businesses.
The data stems from users who choose to give the businesses they visit a rating or review. Businesses have an average rating score that ranges from 0 to 5 stars, and business owners have the option to setup a free account with Yelp in order to post photos and promote their business.

Yelp is extremely popular and by the end of Q1 2017 there have been more than 127 million reviews written by users. According to the [Yelp website](https://www.yelp.com/about) Yelp had a monthly average of 26 million unique visitors who visited Yelp via the Yelp app and 73 million unique visitors who visited Yelp via mobile web in Q1 2017. Only 19% of all businesses that were reviewed by Yelp came from restaurants.  

![](https://media.npr.org/assets/img/2014/05/22/yelp-1_wide-c07e41ca11053d2d7c30aafa94556b2ea5e53f5f.jpg?s=800)  


The Yelp API that we worked with provided us with a variety of data sets that included restaurant names, food categories, average price, locations, average rating, and restaurant name. Because the data was so large, we decided to only focus on certain restaurant in each state that were sorted by what Yelp refers to as "best_match".

This means that the rating sort is not strictly sorted by the rating value, but by an adjusted rating value that takes into account the number of ratings, similar to a [Bayesian average](https://en.wikipedia.org/wiki/Bayesian_average). This is so a business with 1 rating of 5 stars doesn’t immediately jump to the top.

### What Did We Do?
The category for each restaurant was determined by the tags that yelp users and business owners place on the Yelp website or app. Certain restaurants can contain more than one tag. For our project, we chose ten food types that we believed were the most prevalent and popular in the United States. These restaurants include:
* American   
* Italian   
* Mexican  
* Japanese  
* Korean  
* Indian  
* Thai  
* Mediterranean  
* German  
* Chinese

Once we determined our food categories, we decided to make variety of charts that can be found at the top of the page. These charts include:
* A **Word Cloud** that compare the differences in how restaurants of various ethnicity choose the names of their restaurants in Washington State
* A **Stacked Bar graph** that compares restaurant type by price level in major U.S. cities
* A **Map** that shows the mean restaurant rating by type in each state
* A **Scatter Plot** that shows where each type of food lands on a scale of ratings vs average price

### Who Is Our Audience?
Our targeted audience is consumers in the U.S. who are interested in the diversity of food in various locations. With our app, we hope users can explore food trends based on type, ratings, price, and location. After exploring the data, users may be able to relate it to the values, economic status, population, racial diversity, cultural trends, etc. of a region/type of food.

<!-- The first chart is a wordcloud that shows the most popular words in each resturant name seperated by category.  
The second chart is a stacked bar chart that shows the   
The third chart is a scatterplot that shows   

### What did we find?
We found that .


### Why does it matter? -->
