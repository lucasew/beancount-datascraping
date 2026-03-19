import logging
import traceback

logging.basicConfig()
logger = logging.getLogger(__name__)

def report_error(e: Exception, context: str = ""):
    """
    Centralized error reporting function.
    All code paths that handle unexpected errors MUST funnel through this function.
    """
    msg = f"Error: {str(e)}"
    if context:
        msg = f"{context} - {msg}"

    logger.error(msg)
    logger.error(traceback.format_exc())
    # In the future, this is where Sentry.captureException(e) would go
