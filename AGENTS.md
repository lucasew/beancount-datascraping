# Project Conventions

## Where To Find Things

- `src/core` -> Shared Python logic for fetching and data modeling, including `errors.py`, `http.py`, and `models.py`. Nested `fetch` scripts should dynamically append the `src/` directory to `sys.path`.
- `bruto` -> Data acquisition logic, organized by currency and asset type (e.g., `BRL/BR.B3`). Scripts are typically named `fetch`.

## Error Handling

- **Centralized Error Reporting:** All expected and unexpected errors MUST be routed through the single, centralized error-reporting function `report_error(e, context)` located in `src/core/errors.py`. Never call `logger.error` directly. Never leave an empty catch block.