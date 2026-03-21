import functools
import json
import logging
from urllib.request import urlopen, Request

logging.basicConfig()
logger = logging.getLogger(__name__)

USER_AGENT = "Mozilla/5.0 (X11; Linux x86_64; rv:137.0) Gecko/20100101 Firefox/137.0"

@functools.cache
def fetch_body(url: str, fetch_try=0):
    """
    Downloads raw payload from an endpoint and caches it via functools.
    Utilizes a hardcoded browser User-Agent to mitigate 403 blocks from CDNs.
    """
    logger.debug(f"fetch: {url}")
    res = urlopen(Request(url, headers={
        "User-Agent": USER_AGENT,
    }))
    return res.read()

def fetch_json(url: str):
    """
    Loads cached bytes returned by fetch_body and parses them into a Python dict.
    """
    return json.loads(fetch_body(url))
