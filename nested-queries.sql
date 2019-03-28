--This query displays the total count of restaurants by state that are open, have more than 300 reviews, and
-- have star ratings of above average
select state, count(state) as restaurant_count
from Yelp_Dataset.Yelp_Business
where is_open = 1 and review_count > 300 and stars >
(select avg(stars)
from Yelp_Dataset.Yelp_Business)
group by state
order by state

