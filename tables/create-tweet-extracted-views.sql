CREATE MATERIALIZED VIEW view_cve_referring_tweets_extracted_cves AS
SELECT
  id AS tweet_id,
  regexp_matches(text, 'CVE-[0-9]{3,4}-[0-9]{3,7}', 'g') as cve
FROM cve_referring_tweets
WITH DATA;

CREATE MATERIALIZED VIEW view_cve_referring_tweets_extracted_domains AS
SELECT
  id AS tweet_id,
  regexp_matches(text, 'http[s]:\/\/?\ ?([-a-zA-Z0-9:%._\+~#=]{2,255}\.[a-z]{2,6})', 'g') AS domain
FROM cve_referring_tweets
WITH DATA;