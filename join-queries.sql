--This query joins the two files 'Yelp_Review' and 'Yelp_User' through an inner join and displays the user's ID,
--name, count of reviews, and the number of fans of each user who has written at least one review and has more
--than 1,000 fans on Yelp.
Select yu.user_id, yu.name, yu.review_count, yu.friends, yu.fans
From Yelp_Dataset.Yelp_Review yr inner join Yelp_Dataset.Yelp_User yu on yr.user_id = yu.user_id
Where yu.fans > 1000

--This query joins the two files 'Yelp_User' and 'Yelp_Review' through an inner join and displays the user's ID,
--name, number of friends, number of fans, number of compliments for photos, and the number of votes for a 'useful'
--review of each user who has gotten more than 50 compliments on their photos.
Select yu.user_id, yu.name, yu.friends, yu.fans, yu.compliment_photos, yr.useful
From Yelp_Dataset.Yelp_User yu inner join Yelp_Dataset.Yelp_Review yr on yu.user_id = yr.user_id
Where yu.compliment_photos > 50

--This query joins the two files 'Yelp_Business' and 'Yelp_Review' through a left join and displays the
--business' ID, name, the number of reviews, and the number of 'useful' votes on reviews written about the business.
--This query specifically displays businesses that have gotten more than 50 reviews of which more than 50 people
--found it useful.
Select yb.business_id, yb.name, yb.review_count, yr.useful
From Yelp_Dataset.Yelp_Business yb left join Yelp_Dataset.Yelp_Review yr on yb.business_id = yr.business_id
Where yb.review_count > 50
and yr.useful > 50

--This query joins the two files 'Yelp_Business' and 'Yelp_Review' through an outer join and displays the business'
--ID, neighborhood, city, whether or not the business is open, and the number of 'cool' votes on each review of
--businesses located in Toronto or Las Vegas and has more than 5 'cool' votes on reviews.
Select yb.business_id, yb.neighborhood, yb.city, yb.is_open, yr.cool
From Yelp_Dataset.Yelp_Business yb full outer join Yelp_Dataset.Yelp_Review yr on yb.business_id = yr.business_id
Where yb.city = "Toronto" or yb.city = "Las Vegas"
and yr.cool > 5

--This query joins the two files 'Yelp_User' and 'Yelp_Review' through an outer join and displays the user's ID,
--name, date of Yelp account registration, number of fans, 'useful' votes on user, and 'useful' votes on reviews.
--This query specifically displays data of reviews with more than 100 'useful' votes, written by users who got
--more than 200 'useful' votes for themselves.
Select yu.user_id, yu.name, yu.yelping_since, yu.fans, yr.useful as r_useful, yu.useful as u_useful
From Yelp_Dataset.Yelp_User yu full outer join Yelp_Dataset.Yelp_Review yr on yu.user_id = yr.user_id
Where yr.useful > 100
and yu.useful > 200

--This query joins the two files 'Yelp_User' and 'Yelp_Review' through an outser join and displays the user's ID,
--name, number of 'useful' votes on their reviews, and the number of 'cute' compliments on their profile. This
--query displays specifically users with more than 200 fans on Yelp.
Select yr.user_id, yr.useful, yu.name, yu.compliment_cute
From Yelp_Dataset.Yelp_User yu full outer join Yelp_Dataset.Yelp_Review yr on yu.user_id = yr.user_id
Where yu.fans > 200
