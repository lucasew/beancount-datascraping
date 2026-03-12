import json
import logging
from urllib.request import urlopen, Request
import functools

logging.basicConfig()
logger = logging.getLogger(__name__)

USER_AGENT = "Mozilla/5.0 (X11; Linux x86_64; rv:137.0) Gecko/20100101 Firefox/137.0"

@functools.cache
def fetch_body(url: str, fetch_try=0):
    """
    Fetches raw body content from a URL, spoofing a standard browser user agent
    to avoid basic bot protections. Caches results in memory to prevent duplicate
    network requests for the same URL during a single script execution.
    """
    logger.debug(f"fetch: {url}")
    res = urlopen(Request(url, headers={
      "User-Agent": USER_AGENT,
    }))
    return res.read()

def fetch_json(url: str):
    """
    Wraps fetch_body to directly decode the fetched payload as JSON.
    Benefits from the underlying memory cache in fetch_body.
    """
    return json.loads(fetch_body(url))
