--
select city, avg(stars) as avg_stars, sum(review_count) as sum_review
from Yelp_Dataset.Yelp_Business
group by city
having avg(stars) > 4

--
select state, count(business_id) as count_business, sum(is_open) as count_open
from Yelp_Dataset.Yelp_Business
group by state

--
select stars, count(business_id) as count_business, max(review_count) as max_review_count
from Yelp_Dataset.Yelp_Business
where is_open = 1
group by stars
order by stars

--
select user_id, count(review_id) as count_reviews
from Yelp_Dataset.Yelp_Review
where useful > 50
group by user_id
having count(review_id) > 20
order by count_reviews

--
select business_id, avg(stars) as avg_stars, max(cool) as max_cool
from Yelp_Dataset.Yelp_Review
group by business_id
having avg(stars) = 5

--
select user_id, count(review_id) as count_reviews, max(stars) as max_stars, max(useful) as max_useful
from Yelp_Dataset.Yelp_Review
group by user_id
having count(review_id) > 100

--
select fans, count(user_id) as count_users, max(useful) as max_useful
from Yelp_Dataset.Yelp_User
group by fans
having fans > 200
order by fans

--
select average_stars, count(user_id) as count_users, max(fans) as max_fans
from Yelp_Dataset.Yelp_User
where average_stars > 4
group by average_stars
order by average_stars
