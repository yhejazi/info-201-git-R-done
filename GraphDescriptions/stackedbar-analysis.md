#### Notes on the Stacked Bar Charts
- These charts are meant to it easier to compare which types of food most likely fall within certain price levels and how this differs across major U.S. cities.
- The data was collected by collecting the **top 50** restaurants of each category in the given major city
- Since the data pulls the top 50 restaurants for each category, it should be noted that the graph does _not_ create an accurate representation of data for _all_ restaurants in each type of food in the city, but rather the **most popular**.

## Findings
When using the Yelp API, we thought that one way to look at the **diversity** within a community, or in this case city, could be comparing the **types of food** and how their distributions across the 4 **price levels** compared to one another, and how those comparisons differ in various **major cities**. This would not only give a glimpse into the popular types of food depending on the location, but also the economy of the location by how much people are willing to spend, and what types of food generally charge more or less.

After comparing the various stacked bar charts created based on different cities, some initial trends we noticed were:
- Japanese and Italian are more likely to have restaurants in the Ultra High-End price level
- In general, Moderate is the most dominate price level across all listed types of food
- New York has the most similar results when comparing the of number of restaurants per category and each type's price levels
- San Francisco, CA appears to have the most restaurants in the Ultra High-End price range
- German is one of the least common types of food at restaurants

Not surprisingly, cities such as San Francisco which are known to have a high cost of living tended to have more Ultra High-End priced restaurants in their top 50's. However, in each category of food in the city of New York, which is also a highly populated city with a high cost of living, the distribution of price ranges were fairly consistent, mostly falling under Moderate. New York was also the only major city to have _all_ types of food have at least 50 restaurants. Seattle and Houston in general had the most inexpensive restaurants in their top 50's.

It is also important to consider what this chart is unable to narrate. For example, we chose 9 categories of food to compare, but it is possible that in cities that appear to have less 'diversity', may have another category of food, that we did not include, be more prominent than other states which would increase it's 'diversity'. In addition, since the max number of restaurants considered per type is 50, the graph is unable to compare restaurants that go beyond the 50 maximum. 
