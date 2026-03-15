import logging

logger = logging.getLogger(__name__)

def report_error(e: Exception, context: dict = None):
    """
    Centralized error reporting function.
    Logs the exception with optional context.
    """
    if context:
        logger.error(f"Error occurred: {e} | Context: {context}", exc_info=True)
    else:
        logger.error(f"Error occurred: {e}", exc_info=True)
