select count(distinct business_id), count(business_id)
from `Yelp_Dataset.Yelp_Business` 

select count(distinct review_id), count(review_id)
from `Yelp_Dataset.Yelp_Review` 

select count(distinct user_id), count(user_id)
from `Yelp_Dataset.Yelp_User` 

select b.name, r.review_id
from Yelp_Dataset.Yelp_Review r left outer join Yelp_Dataset.Yelp_Business b
on r.business_id = b.business_id

select b.name, r.review_id
from Yelp_Dataset.Yelp_Review r left outer join Yelp_Dataset.Yelp_Business b
on r.business_id = b.business_id
where b.business_id is null


select u.name, r.review_id
from Yelp_Dataset.Yelp_Review r left outer join Yelp_Dataset.Yelp_User u
on r.user_id = u.user_id
where user_id is null

delete
from Yelp_Dataset.Yelp_Review 
where review_id = 'zKauMURiykqRFymXy3s-cw'
or review_id = 'AVe60fnQlcqJHvRn7STppQ'
or review_id = 'TFCukgJEZC0ZlsYbCHPS5w'
or review_id = 'GrDg_1B7uqg62NCU3zI1Ig'
or review_id = 'jFHjPaUpSJUJXuykCzwxxA'
or review_id = 'M6vRG_faDZIyswkUZQBTVA'
 


