--From our 'Yelp_Business' table, this query selects all the data of businesses located in Las Vegas. The data is
--in an ascending order of review counts.
Select * From Yelp_Dataset.Yelp_Business
Where city = 'Las Vegas'
Order by review_count

--From our 'Yelp_Review' table, this query selects all the data of reviews, which more than 50 users believed
--to be useful. The data is in ordered by review IDs.
Select * From Yelp_Dataset.Yelp_Review
Where useful > 50
Order by review_id

--From our 'Yelp_User' table, this query displays the name of user, review counts, user's yelp account registration
--date, and number of fans of users who have more than 100 fans. The data is ordered by earlist account registration
--date to the latest date.
Select name, review_count, yelping_since, fans From Yelp_Dataset.Yelp_User
Where fans > 100
Order by yelping_since
