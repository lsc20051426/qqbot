
from selenium import webdriver
from time import sleep
import web
from bottle import route, run, template

browser = webdriver.Chrome()
browser.get('http://www.simsimi.com/')
sleep(5)
btns = browser.find_elements_by_class_name('btn-default-lang')
btns[2].click()
sleep(15)
browser.get('http://www.simsimi.com/settings.htm')
sleep(5)
nobadword = browser.find_element_by_name('no')
nobadword.click()
browser.get('http://www.simsimi.com/talk.htm')


def get_cookies():
    return "; ".join(["=".join([c['name'], c['value']]) 
            for c in browser.get_cookies() if c['domain'].endswith('.simsimi.com')])



@route('/')
def index():
    return get_cookies()

@route('/refresh')
def refresh():
    browser.refresh()
    return "1"

run(host='localhost', port=8080)