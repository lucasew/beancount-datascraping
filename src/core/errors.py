import logging

logging.basicConfig()
logger = logging.getLogger(__name__)

def report_error(e: Exception):
    """
    Centralized error reporting function. All code paths that handle unexpected
    errors must funnel through this function.
    """
    logger.error(e)
