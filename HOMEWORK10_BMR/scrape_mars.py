
# dependencies
import time
import pandas as pd
from bs4 import BeautifulSoup
from splinter import Browser


def init_browser():
    !which chromedriver
    executable_path = {'executable_path': '/usr/local/bin/chromedriver'}
    return Browser('chrome', **executable_path, headless=False)

#scrape
def scrape():
    browser = init_browser()

    title, first_paragraph = mars_news(browser)

    # save dictionary
    results = {
        "title": title,
        "paragraph": first_paragraph,
        "image_URL": jpl_image(browser),
        "weather": mars_weather(browser),
        "facts": mars_facts(),
        "hemispheres": mars_hemi(browser),
    }

    #quit and return results
    browser.quit()
    return results

def mars_news(browser):

    # NASA url
    nasa_url = 'https://mars.nasa.gov/news/'
    browser.visit(nasa_url)
    time.sleep(1)
    nasa_html = browser.html
    nasa_soup = BeautifulSoup(nasa_html, 'html.parser')

    # scrape title
    title = news_soup.find('div', class_='content_title').text
    # scrape news paragraph
    first_paragraph = news_soup.find('div', class_='article_teaser_body').text
    return title, first_paragraph

def jpl_image(browser):
    # URL of page to be scraped
    url = 'https://www.jpl.nasa.gov/spaceimages/?search=&category=Mars'
    browser.visit(url)
    # Go to 'FULL IMAGE'
    browser.click_link_by_partial_text('FULL IMAGE')
    # Go to 'more info'
    browser.click_link_by_partial_text('more info')
    # HTML object
    html = browser.html
    # parse BeautifulSoup
    image_soup = BeautifulSoup(html, 'html.parser')
    # complete URL string
    featured_image = image_soup.find('figure', class_='lede').a['href']
    featured_image_url = f'https://www.jpl.nasa.gov{featured_image}'
    return featured_image_url

def mars_weather(browser):
    # URL of page to be scraped
    url = 'https://twitter.com/marswxreport?lang=en'
    browser.visit(url)
    # HTML object
    html = browser.html
    # parse BeautifulSoup
    tweet_soup = BeautifulSoup(html, 'html.parser')
    # find tweet
    tweets = tweet_soup.find('p', class_='TweetTextSize').text
    return tweets

def mars_facts():
    # URL of page to be scraped
    url = 'https://space-facts.com/mars/'
    browser.visit(url)
    # use Pandas to scrape the table
    facts = pd.read_html(url)
    # create df
    facts_df = facts[0]
    facts_df.columns = ['Property', 'Mars', 'Earth']
    return facts_df.to_html

def mars_hemi(browser):
    # URL of page to be scraped
    url = 'https://astrogeology.usgs.gov/search/results?q=hemisphere+enhanced&k1=target&v1=Mars'
    browser.visit(url)
    # HTML object
    html = browser.html
    # parse BeautifulSoup
    mars_soup = BeautifulSoup(html, 'html.parser')
    # scrape mars hemispheres information
    items = mars_soup.find_all('div', class_='item')

    # Create empty list for hemisphere urls 
    hemisphere_image_urls = []

    # Store the main_url
    main_url = 'https://astrogeology.usgs.gov'

    # Loop through the items previously stored
    for i in items:
        # Store
        title = i.find('h3').text
        image_url = i.find('a', class_='itemLink product-item')['href']

        # Visit the link
        browser.visit(main_url + image_url)

        # HTML Object of individual hemisphere information website
        image_html = browser.html

        # Parse HTML with Soup
        hemi_soup = BeautifulSoup(image_html, 'html.parser')

        # Retrieve image source
        image_url = main_url + hemi_soup.find('img', class_='wide-image')['src']

        # Append the retreived information into a list of dictionaries
        hemisphere_image_urls.append({"title" : title, "img_url" : image_url})


    # Display hemisphere_image_urls
    return hemisphere_image_urls
