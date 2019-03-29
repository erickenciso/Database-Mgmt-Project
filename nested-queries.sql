--This query displays the total count of restaurants by state that are open, have more than 300 reviews, and
-- have star ratings of above average
select state, count(state) as restaurant_count
from `inner-chassis-230421.Yelp_Dataset.Yelp_Business`
where is_open = 1 and review_count > 300 and stars >
(select avg(stars)
from `inner-chassis-230421.Yelp_Dataset.Yelp_Business`)
group by state
order by state

--This query displays the information of users who wrote more than 1000 reviews, have more than 500 'useful' votes,
--and have star ratings greater than average
select user_id, name, review_count, yelping_since, useful, average_stars
from Yelp_Dataset.Yelp_User
where review_count > 1000 and useful > 500 and average_stars >
(select avg(average_stars)
from Yelp_Dataset.Yelp_User)

--This query displays the information of businesses which received more than 100 'useful' votes on reviews
--and have reviews that received star ratings greater than average.
select yb.business_id, yb.name, yb.city, yb.state, yb.stars, yb.review_count
from Yelp_Dataset.Yelp_Business yb
inner join Yelp_Dataset.Yelp_Review yr on yb.business_id = yr.business_id
where yr.useful > 100 and yr.stars > (select avg(stars) from Yelp_Dataset.Yelp_Review)

--This query displays the number of businesses in each star rating (1-5). This query specifically shows businesses
--that received reviews from users who have written more than 1000 reviews and have more than 1000 fans.
select stars, count(business_id) as business_count
from `inner-chassis-230421.Yelp_Dataset.Yelp_Review`
where user_id in 
(select yr.user_id from `inner-chassis-230421.Yelp_Dataset.Yelp_Review` yr
inner join `inner-chassis-230421.Yelp_Dataset.Yelp_User` yu on yr.user_id = yu.user_id
where yu.review_count > 1000 and yu.fans > 1000)
group by stars
order by stars
