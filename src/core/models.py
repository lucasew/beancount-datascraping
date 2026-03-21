from dataclasses import dataclass
from datetime import date
from typing import Any

@dataclass
class Entry:
    """
    Represents a single scraped data point for a ticker. Designed
    to map easily to a CSV row format representing time series data.
    """
    day: date
    price: float

    @property
    def columns(self):
        return ['day', 'price']

    @property
    def line(self):
        return {"day": str(self.day), "price": self.price}
