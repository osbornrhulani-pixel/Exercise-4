--- creating catalog
CREATE CATALOG IF NOT EXISTS exercise_n04;
USE CATALOG exercise_n04;
--- creating schema
CREATE SCHEMA IF NOT EXISTS exercise_n04.joins;
--- creating first table
CREATE TABLE IF NOT EXISTS exercise_n04.joins.users (
    user_id INT,
    user_name STRING,
    country STRING);
--- inserting values into the table
INSERT INTO exercise_n04.joins.users VALUES
(1, 'Nomvula', 'Johannesburg'),
(2, 'David', 'Cape Town'),
(3, 'Anele', 'Durban'),
(4, 'Kabelo', 'Pretoria'),
(5, 'Lerato', 'Port Elizabeth');
---- query table
SELECT * FROM exercise_n04.joins.users;
--- creating second table
CREATE TABLE IF NOT EXISTS exercise_n04.joins.plans (
    plan_id INT,
    plan_name STRING,
    monthly_price INT);
--- inserting values into the table
INSERT INTO exercise_n04.joins.plans VALUES
(10, 'Basic', 79),
(11, 'Standard', 129),
(12, 'Premium', 199),
(13, 'Family', 249),
(14, 'Mobile', 59);
--- query table
SELECT * FROM exercise_n04.joins.plans;
--- creating third table
CREATE TABLE IF NOT EXISTS exercise_n04.joins.subscriptions (
    subscription_id INT,
    user_id INT,
    plan_id INT,
    start_date DATE);
--- inserting values into the table
INSERT INTO exercise_n04.joins.subscriptions VALUES
(501, 1, 10, '2026-01-15'),
(502, 2, 11, '2026-02-01'),
(503, 1, 12, '2026-03-10'),
(504, 6, 11, '2026-03-20'),
(505, 3, 13, '2026-04-05'); 
--- query table
SELECT * FROM exercise_n04.joins.subscriptions;
--- creating fourth table
CREATE TABLE IF NOT EXISTS exercise_n04.joins.shows (
    show_id INT,
    show_title STRING,
    genre STRING);
--- inserting values into the table
INSERT INTO exercise_n04.joins.shows VALUES
(701, 'Comedy Hour', 'Comedy'),
(702, 'Crime Time', 'Drama'),
(703, 'Tech Tales', 'Documentary'),
(704, 'Cooking Lab', 'Lifestyle'),
(706, 'Wild Earth', 'Documentary');
--- query table
SELECT * FROM exercise_n04.joins.shows;
--- creating fifth table
CREATE TABLE IF NOT EXISTS exercise_n04.joins.viewing_sessions (
    session_id INT,
    user_id INT,
    show_id INT,
    watch_minutes INT);
--- inserting values into the table
INSERT INTO exercise_n04.joins.viewing_sessions VALUES
(901, 1, 701, 45),
(902, 2, 703, 30),
(903, 1, 702, 60),
(904, 7, 701, 20),
(905, 3, 705, 90);
--- query
SELECT * FROM exercise_n04.joins.viewing_sessions;

---- part A, INNER JOIN
--- question 1: show every user who has a subscription. match users to subscriptions.
SELECT users.user_id,
       users.user_name,
       subscriptions.subscription_id,
       subscriptions.start_date
FROM exercise_n04.joins.users AS users
INNER JOIN exercise_n04.joins.subscriptions AS subscriptions
ON users.user_id = subscriptions.user_id;
--- question 2: show every subscription with its matching plan name and monthly price.
SELECT subscriptions.subscription_id,
       subscriptions.user_id,
       plans.plan_name,
       plans.monthly_price
FROM exercise_n04.joins.subscriptions AS subscriptions
INNER JOIN exercise_n04.joins.plans AS plans
ON subscriptions.plan_id = plans.plan_id;
--- question 3: show every viewing session that has a matching show. include the show title and genre
SELECT viewing_sessions.session_id,
       viewing_sessions.user_id,
       shows.show_title,
       shows.genre,
       viewing_sessions.watch_minutes
FROM exercise_n04.joins.viewing_sessions AS viewing_sessions
INNER JOIN exercise_n04.joins.shows AS shows
ON viewing_sessions.show_id = shows.show_id;
--- question 4: show every viewing session with the user who watched it. only show sessions with a matching user
SELECT users.user_name,
       users.country,
       viewing_sessions.session_id,
       viewing_sessions.watch_minutes
FROM exercise_n04.joins.users AS users
INNER JOIN exercise_n04.joins.viewing_sessions AS viewing_sessions
ON users.user_id = viewing_sessions.user_id;
--- question 05: show users along with their subscriptions, the plan name, and price. use only users who have both a subscrition and a valid plan.
SELECT users.user_name,
       users.country,
       plans.plan_name,
       plans.monthly_price,
       subscriptions.start_date
FROM exercise_n04.joins.users AS users
INNER JOIN exercise_n04.joins.subscriptions AS subscriptions
ON users.user_id = subscriptions.user_id
INNER JOIN exercise_n04.joins.plans AS plans
ON subscriptions.plan_id = plans.plan_id;
---- question 6: show every user and any subscription they have. users without subscriptions must still appear
SELECT users.user_id,
       users.country,
       subscriptions.subscription_id,
       subscriptions.start_date
FROM exercise_n04.joins.users AS users
LEFT JOIN exercise_n04.joins.subscriptions AS subscriptions
ON users.user_id = subscriptions.user_id;
--- question 7: Show every plan and the subscription on it. Plans with no subscriptions must still appear. 
SELECT plans.plan_id,
       plans.plan_name,
       subscriptions.subscription_id,
       subscriptions.user_id
FROM exercise_n04.joins.plans AS plans
LEFT JOIN exercise_n04.joins.subscriptions AS subscriptions
ON plans.plan_id = subscriptions.plan_id;
--- question 8: Show every show and any viewing sessions on it. Shows that were never watched must still appear.
SELECT shows.show_id,
       shows.show_title,
       viewing_sessions.session_id,
       viewing_sessions.watch_minutes
FROM exercise_n04.joins.shows AS shows
LEFT JOIN exercise_n04.joins.viewing_sessions AS viewing_sessions
ON shows.show_id = viewing_sessions.show_id;

--- question 09: Show every viewing session and the user who watched it. Sessions referencing users that do not exist must still appear (with NULL user details). 
SELECT viewing_sessions.session_id,
       viewing_sessions.watch_minutes,
       users.user_id,
       users.user_name
FROM exercise_n04.joins.viewing_sessions AS viewing_sessions
LEFT JOIN exercise_n04.joins.users AS users
ON viewing_sessions.user_id = users.user_id;
---question 10: Show every user, the plan they are on (if any) , and the monthly prices. Users without a subscription must still appear.
SELECT users.user_id,
       users.country,
       plans.plan_name,
       plans.monthly_price
FROM exercise_n04.joins.users AS users
LEFT JOIN exercise_n04.joins.subscriptions AS subscriptions
ON users.user_id = subscriptions.user_id
LEFT JOIN exercise_n04.joins.plans AS plans
ON subscriptions.plan_id = plans.plan_id;
--- QUESTION 11: Show every user and every subscription, including users without subscriptions and subscriptions referencing users that do not exist.
SELECT users.user_id,
       users.user_name,
       subscriptions.subscription_id,
       subscriptions.start_date
FROM exercise_n04.joins.users AS users
FULL OUTER JOIN exercise_n04.joins.subscriptions AS subscriptions
ON users.user_id = subscriptions.user_id;
--- question 13: Show every plan and every subscription, including plans without subscribers AND any subscription referencing a plan that does not exist.
SELECT plans.plan_id,
       plans.plan_name,
       subscriptions.subscription_id,
       subscriptions.user_id
FROM exercise_n04.joins.plans AS plans
FULL OUTER JOIN exercise_n04.joins.subscriptions AS subscriptions
ON plans.plan_id = subscriptions.plan_id;
--- question 13: Show every show and viewing session, including shows that were never watched AND sessions referencing shows that do not exist
SELECT shows.show_id,
       shows.show_title,
       viewing_sessions.session_id,
       viewing_sessions.watch_minutes
FROM exercise_n04.joins.shows AS shows
FULL OUTER JOIN exercise_n04.joins.viewing_sessions AS viewing_sessions
ON shows.show_id = viewing_sessions.show_id;
--- question 14:Show every user and viewing session, including users with no sessions AND sessions referencing users who do not exist 
SELECT users.user_id,
       users.user_name,
       viewing_sessions.session_id,
       viewing_sessions.show_id,
       viewing_sessions.watch_minutes
FROM exercise_n04.joins.users AS users
FULL OUTER JOIN exercise_n04.joins.viewing_sessions AS viewing_sessions
ON users.user_id = viewing_sessions.user_id;
--- question 15: Show every user, every subscription, and every plan in one query- using FULL OUTER JOIN throughout. 
SELECT users.user_id,
       users.user_name,
       subscriptions.subscription_id,
       plans.plan_id,
       plans.plan_name
FROM exercise_n04.joins.users AS users
FULL OUTER JOIN exercise_n04.joins.subscriptions AS subscriptions
ON users.user_id = subscriptions.user_id
FULL OUTER JOIN exercise_n04.joins.plans AS plans
ON subscriptions.plan_id = plans.plan_id;



        
