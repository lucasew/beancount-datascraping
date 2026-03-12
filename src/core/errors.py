import logging

logging.basicConfig(level=logging.ERROR)
logger = logging.getLogger(__name__)

def report_error(e: Exception, context: dict = None):
    """
    Centralized error reporting function.
    All code paths that handle unexpected errors MUST funnel through this function.
    """
    error_msg = f"Unexpected error occurred: {e}"
    if context:
        error_msg += f" | Context: {context}"
    logger.error(error_msg, exc_info=True)
