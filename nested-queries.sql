--This query displays the total count of restaurants by state that are open, have more than 300 reviews, and
-- have star ratings of above average
select state, count(state) as restaurant_count
from Yelp_Dataset.Yelp_Business
where is_open = 1 and review_count > 300 and stars >
(select avg(stars)
from Yelp_Dataset.Yelp_Business)
group by state
order by state

--This query displays the information of users who wrote more than 1000 reviews, have more than 500 'useful' votes,
--and have star ratings greater than average
select user_id, name, review_count, yelping_since, useful, average_stars
from Yelp_Dataset.Yelp_User
where review_count > 1000 and useful > 500 and average_stars >
(select avg(average_stars)
from Yelp_Dataset.Yelp_User)
