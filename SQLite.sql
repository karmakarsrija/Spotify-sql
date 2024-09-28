SELECT * from spotify_top50_2021;
--What is the average danceability by artist? 
SELECT artist_name,avg(danceability) AS average_danceability FROM spotify_top50_2021 GROUP by artist_name ORDER BY average_danceability DESC;

--Who are the top 10 artists based on popularity, and what are their tracks' average danceability and energy?
SELECT artist_name,avg(popularity) AS avg_popularity,avg(danceability) AS average_danceability, avg(energy) AS avg_energy FROM spotify_top50_2021 GROUP BY artist_name ORDER BY avg_popularity DESC LIMIT 10;

--What artist released the longest song?
SELECT artist_name,track_name,duration_ms FROM spotify_top50_2021 ORDER BY duration_ms DESC LIMIT 1;

--What is the average danceability of the top 12 most popular songs?
SELECT avg(danceability) AS average_danceability FROM (SELECT danceability FROM spotify_top50_2021 ORDER by 
                                                                   popularity DESC LIMIT 12) as top_12_popu_song;




--Query the artists in top 50 and the count of top songs by each artist
SELECT artist_name,COUNT(*) FROM spotify_top50_2021 GROUP by artist_name order by COUNT(*) DESC;

--Query the songs that have another artist featured on them
SELECT track_name FROM spotify_top50_2021
WHERE track_name like '%feat%' OR track_name LIKE '%ft%';

SELECT COUNT(*) FROM spotify_top50_2021
WHERE track_name like '%feat%' OR track_name LIKE '%ft%';

--Query the Average Energy from TopSongs
SELECT ROUND(avg(energy),2) as average_energy FROM spotify_top50_2021;

WITH average_energy AS (
    SELECT ROUND(AVG(energy), 2) AS avg_energy 
    FROM spotify_top50_2021
)
SELECT track_name, artist_name, energy,
CASE
    WHEN energy > ae.avg_energy THEN 'above average'
    WHEN energy = ae.avg_energy THEN 'average'
    WHEN energy < ae.avg_energy THEN 'below average'
END AS compare_energy 
FROM spotify_top50_2021, average_energy AS ae;


SELECT ROUND(avg(loudness),2) as average_loud FROM spotify_top50_2021;

WITH average_loud AS (
    SELECT AVG(loudness) AS average_loud
    FROM spotify_top50_2021
)
SELECT track_name, artist_name, loudness,
CASE
    WHEN loudness > ae.average_loud THEN 'above average'
    WHEN loudness = ae.average_loud THEN 'average'
    WHEN loudness < ae.average_loud THEN 'below average'
END AS compare_loud
FROM spotify_top50_2021, average_loud AS ae;


---Valence

SELECT ROUND(AVG(valence), 3) as avg_valence FROM spotify_top50_2021;

WITH average_valence AS (
    SELECT AVG(valence) AS avg_valence
    FROM spotify_top50_2021
)
SELECT compare_valence, COUNT(compare_valence) AS count 
FROM (
    SELECT track_name, artist_name, valence,
    CASE
        WHEN valence > av.avg_valence THEN 'above average'
        WHEN valence = av.avg_valence THEN 'average'
        WHEN valence < av.avg_valence THEN 'below average'
    END AS compare_valence
    FROM spotify_top50_2021, average_valence AS av
) AS subquery
GROUP BY compare_valence;