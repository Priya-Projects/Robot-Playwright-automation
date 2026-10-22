# Robot Framework Test Automation: UI + API

Test automation framework built with **Robot Framework**, covering both UI and REST API testing.

## UI Automation

UI tests are built with **Robot Framework** and **Browser Library** (which runs on **Playwright**). They run against [Sauce Demo](https://www.saucedemo.com), a public practice e-commerce site.

## API Automation

API tests are built with **Robot Framework** and **RequestsLibrary** (which provides HTTP request keywords for REST API testing). They run against [JSONPlaceholder](https://jsonplaceholder.typicode.com), a free public practice API.

## Tech stack

| Tool | Purpose |
|---|---|
| Robot Framework | Test framework and reporting |
| Browser Library | Robot Framework wrapper around Playwright |
| Playwright (Node.js) | Drives the browser (Chromium) |
| RequestsLibrary | HTTP client for REST API tests |
| Python 3.9+ | Runtime for Robot Framework |

## What is tested
**UI**
| ID | Scenario |
|---|---|
| TC01 | Valid login shows the inventory page |
| TC02 | Locked-out user sees the correct error message |
| TC03 | Products are displayed on the inventory page |
| TC05 | Products Are added to the cart And Cart badge count matches the number of products added |
| TC06 | Products Are Removed From Cart And Cart Badge Number Decreases Based On Products Removal |
**API**
| ID | Scenario |
|---|---|
| API01 | Get Single User Returns Correct Details |
| API02 | Get All Posts Returns A List |
| API03 | Posts Filtered By User Belong To That User |
| API04 | Create Post Returns Created Data |
| API05 | Update Post Returns Updated Data |
| API06 | Delete Post Returns Success |
| API07| Unknown Post Returns 404 |

## Project structure

```
.
├── resources/
│   └── ui_keywords.resource    # Variables and reusable keywords (login, add to cart, verifications)
    └── api_keywords.resource    # Variables and resusable keywords(GET, POST, UPDATE and DELETE)
├── tests/
│   └── saucedemotests.robot       # UI Test cases
    |__ api_sampletests.robot      # API Test cases
├── requirements.txt            # Python dependencies
└── README.md
```

Test cases contain only high-level steps. Selectors, test data and keyword logic live in `resources/ui_keywords.resource`, so a locator change is fixed in one place.

## Prerequisites

- Python 3.9 or later
- Node.js (LTS), required by Playwright
- Git

## Setup

```powershell
# 1. Clone the repository
git clone https://github.com/Priya-Projects/Robot-Playwright-automation.git
cd Robot-Playwright-automation

# 2. Create and activate a virtual environment
python -m venv .venv
.venv\Scripts\activate            # Windows (PowerShell)
# source .venv/bin/activate       # macOS / Linux

# 3. Install dependencies
pip install -r requirements.txt

# 4. Download the Playwright browsers
rfbrowser init
```

## Running the tests

Run all tests:

```powershell
robot --outputdir results tests/
```

Run a single test case:

```powershell
robot --outputdir results --test "TC01*" tests/
```

Run by tag (once tests are tagged):

```powershell
robot --outputdir results --include smoke tests/
```

## Reports

After a run, open these files from the `results/` folder in a browser:

- `report.html`: pass/fail summary
- `log.html`: step-by-step execution details, including embedded screenshots for failed tests

## Key features

- Page-level keywords kept in a resource file, separate from test cases
- Assertions built into Browser Library `Get ...` keywords, with automatic retry
- Screenshot captured on test failure
- Selectors based on stable attributes (`id`, `data-test`, ARIA roles)

## Roadmap

- [ ] Combined UI + API test flow
- [ ] Tags for smoke and regression suites
- [ ] CI pipeline (GitHub Actions)
