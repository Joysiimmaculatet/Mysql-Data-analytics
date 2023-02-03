CREATE TEMPORARY TABLE hotels AS
SELECT * FROM `2018`
UNION
SELECT * FROM `2019`
UNION
SELECT * FROM `2020`;

SELECT * FROM hotels
LEFT JOIN market_seg ON hotels.market_segment = market_seg.market_segment
LEFT JOIN meal_cost ON hotels.meal= meal_cost.meal;
