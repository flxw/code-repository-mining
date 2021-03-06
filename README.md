# Introduction
This repository contains the code for the application presented at [flxw.de/code-repository-mining](http://flxw.de/code-repository-mining).
It is a Python 3 client-server application. Please follow the subsections below to setup the individual parts:

The directory contents are as follows:
1. `client` contains the code that runs client-side
2. `server` contains the code running server-side, providing an API
3. `data`   contains the scripts needed for creating the necessary tables and views
4. `docs`   contains several the project website, several artifacts and raw Jupyter notebooks


## Client setup
1. Change directories to the `client/` folder and install the dependencies:
```
pip install -r requirements.txt
```

Then, simply scan your system for vulnerable packages via: `./checksystem.py`. Currently, only apt and pacman
package managers are supported, which translates to most Debian or Arch based Linux distributions.
To simulate the results that this application could potentially give, run `./checksystem.py --test`.
It will show results for openssl package affected by Heartbleed.

## Server setup
This setup assumes the GHtorrent database dump at the HPI chair for software architecture.
Furthermore a mongoDB instance needs to be running and you need to have access to it.
The data procurement and setup is time-consuming:

1. Change directories to `data/`
2. Copy the `config.py.smpl` to `config.py` and edit it so it works for your installation
2. Copy `config.py` to `server/`as well
3. Run `create-cve-search-view.sql`.  Wait for completion.
4. Install `scrapy` via `pip install scrapy`
5. Download [my TweetScraper fork](https://github.com/flxw/TweetScraper)
6. Configure the TweetScraper via its `settings.py` to reflect your PostgreSQL settings and have the TweetScraper use it
7. Run `./crawl-cve-tweets-from-github-subset` *from inside* the TweetScraper project directory. You can go ahead with the next step while the crawler is doing its thing.
8. Download and setup [cve-search](https://github.com/cve-search/cve-search). Wait for completion here.
9. Run `mine-cve-search-into-postgres.py`. Wait for completion.
11. Run `create-reference-url-extraction-view.sql`, `create-tweet-extracted-views.sql`, `create-cwe-nist-reference-ranking.sql` and `create-twitter-user-ranking.sql`. In that order.

The API server setup is straightforward and can be summarized in three commands:
```
cd server
pip install -r requirements.txt
hug -f api.py
```
