--This query joins multiple tables from Dataset1 and Dataset2 to show the relationship between Yelp average ratings
--and the average of stock open prices of businesses.
select sp.Name, avg(yr.stars) as Avg_Ratings, avg(sp.open) as Avg_Open
from Yelp_Dataset.Yelp_Reviews yr
inner join Sp500_Dataset.Ticker_Symbol ts on yr.business_id = ts.business_id
inner join Sp500_Dataset.SP500 sp on ts.ticker = sp.Name
inner join Yelp_Dataset.Yelp_Business yb on yr.business_id = yb.business_id
group by sp.Name
order by name

--This query joins multiple tables from Dataset1 and Dataset2 to show the relationship between the popularity of
--businesses (total review count) and the total number of shares traded.
select sp.Name, sum(yb.review_count) as total_reviews, sum(sp.volume) as total_shares
from Yelp_Dataset.Yelp_Business yb
inner join Sp500_Dataset.Ticker_Symbol ts on yb.business_id = ts.business_id
inner join Sp500_Dataset.SP500 sp on ts.ticker = sp.Name
group by sp.Name
order by total_reviews desc

--This query joins multiple tables from Dataset1 and Dataset2 to show the relationship between Yelp average
--ratings and the stability in stock prices (high - low).
select sp.Name, avg(yb.stars) as Avg_Ratings, avg(sp.high-sp.low) as stability
from Yelp_Dataset.Yelp_Business yb
inner join Sp500_Dataset.Ticker_Symbol ts on yb.business_id = ts.business_id
inner join Sp500_Dataset.SP500 sp on ts.ticker = sp.Name
group by sp.Name
order by Avg_Ratings desc

--This query joins multiple tables from Datasaet1 and Dataset2 to show the relationship between Yelp average
--star ratings and the difference between open and close prices (close - open).
select sp.Name, avg(yb.stars) as Avg_Ratings, avg(sp.close-sp.open) as difference
from Yelp_Dataset.Yelp_Business yb
inner join Sp500_Dataset.Ticker_Symbol ts on yb.business_id = ts.business_id
inner join Sp500_Dataset.SP500 sp on ts.ticker = sp.Name
group by sp.Name
order by Avg_Ratings desc

--This query joins multiple tables from Dataset1 and Dataset2 to show if there is a correlation between the
--change in stock prices and the change in average ratings for Starbucks over the 5 years (monthly).
select sp.date, yb.name, avg(yr.stars) as Avg_Ratings, avg(sp.open) as Avg_Open
from Yelp_Dataset.Yelp_Reviews yr
inner join Yelp_Dataset.Yelp_Business yb on yr.business_id = yb.business_id
inner join Sp500_Dataset.Ticker_Symbol ts on yr.business_id = ts.business_id
inner join Sp500_Dataset.SP500 sp on ts.ticker = sp.Name
where sp.Name = "SBUX"
group by sp.date, yb.name
order by sp.date

--This query joins multiple tables from Dataset1 and Dataset2 to show if there is a correlation between the
--change in stock prices and the change in average ratings for McDonald's over the 5 years (monthly)
select sp.date, yb.name, avg(yr.stars) as Avg_Ratings, avg(sp.open) as Avg_Open
from Yelp_Dataset.Yelp_Reviews yr
inner join Yelp_Dataset.Yelp_Business yb on yr.business_id = yb.business_id
inner join Sp500_Dataset.Ticker_Symbol ts on yr.business_id = ts.business_id
inner join Sp500_Dataset.SP500 sp on ts.ticker = sp.Name
where sp.Name = "MCD"
group by sp.date, yb.name
order by sp.date
