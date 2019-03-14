--From the Yelp_Business table, this query groups the average star rating and the total number of reviews by city. 
--This query also specifically displays data that have an average star rating greater than 4.
select city, avg(stars) as avg_stars, sum(review_count) as sum_review
from Yelp_Dataset.Yelp_Business
group by city
having avg(stars) > 4

--From the Yelp_Business table, by groupding the data by state, this query shows how many businesses are in each 
--state and how many of them are open.
select state, count(business_id) as count_business, sum(is_open) as count_open
from Yelp_Dataset.Yelp_Business
group by state

--From the Yelp_Business table, the data is grouped and ordered by the star rating. The query displays the number of
--open businesses in each star rating. For each star rating, the query also displays the maximum number of reviews 
--a business has received.
select stars, count(business_id) as count_business, max(review_count) as max_review_count
from Yelp_Dataset.Yelp_Business
where is_open = 1
group by stars
order by stars

--From the Yelp_Review table, this query counts the number of reviews writen by each user.
--The query specifies the review count to reviews which got over 50 'useful' votes and narrows the
--output to users who have written more than 20 reviews. The output is also ordered in an ascending order of the
--number of reviews.
select user_id, count(review_id) as count_reviews
from Yelp_Dataset.Yelp_Review
where useful > 50
group by user_id
having count(review_id) > 20
order by count_reviews

--From the Yelp_Review table, this query displays the average star ratings and the maximum 'cool' votes for each
--business. This query also narrows the output to businesses that have an average star rating of 5.
select business_id, avg(stars) as avg_stars, max(cool) as max_cool
from Yelp_Dataset.Yelp_Review
group by business_id
having avg(stars) = 5

--From the Yelp_Review table, this query displays the total amount of reviews, maximum star rating, and the maximum
--'useful' votes each user received. This query also limits the output to users who has written more than 100 reviews.
select user_id, count(review_id) as count_reviews, max(stars) as max_stars, max(useful) as max_useful
from Yelp_Dataset.Yelp_Review
group by user_id
having count(review_id) > 100

--From the Yelp_User table, the data is grouped by the total number fans. This query shows how many users have a specific
--number of fans and the maximum 'useful' votes a user from each group has received. The output is limited to users who
--have more than 200 fans.
select fans, count(user_id) as count_users, max(useful) as max_useful
from Yelp_Dataset.Yelp_User
group by fans
having fans > 200
order by fans

--From the Yelp_User table, this query groups the data by the average stars. The output shows the total number of users
--and the maximum number of fans a user from each group has. The output is limits the average star rating to greater
--than 4.
select average_stars, count(user_id) as count_users, max(fans) as max_fans
from Yelp_Dataset.Yelp_User
where average_stars > 4
group by average_stars
order by average_stars
