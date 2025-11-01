# Testing Instructions

## Changes Committed & Pushed ✅
All fixes have been committed and pushed to the main branch:
- Fixed Zillow XPath scraping
- Updated GitHub Actions workflow
- Created custom scraper with premium API support
- Cleaned old data
- Added comprehensive changelog

## Workflow Status
The workflow is configured to run:
- **Scheduled**: Daily at 5:00 AM UTC
- **Manual**: Can be triggered via GitHub Actions UI

## How to Manually Test the Workflow

### Option 1: Via GitHub Web Interface (Recommended)
1. Go to: https://github.com/sanzgiri/zrscraper/actions/workflows/real-estate-scrape.yml
2. Click **"Run workflow"** button (top right, green button)
3. Ensure **"main"** branch is selected
4. Click **"Run workflow"**
5. Watch the workflow execute in real-time

### Option 2: Via Command Line (if you have workflow permissions)
```bash
gh workflow run real-estate-scrape.yml
```

## Monitoring Workflow Runs

### Check Latest Run Status
```bash
./check_workflow.sh
```

### Watch a Run in Real-Time
```bash
# Get the latest run ID and watch it
gh run watch $(gh run list --workflow=real-estate-scrape.yml --limit 1 --json databaseId --jq '.[0].databaseId')
```

### View Run Logs
```bash
# List recent runs
gh run list --workflow=real-estate-scrape.yml --limit 5

# View specific run (replace ID)
gh run view <RUN_ID> --log
```

## Expected Results

When the workflow runs successfully:
1. ✅ Scrapes Redfin estimate (~$1,188,214)
2. ✅ Scrapes Zillow Zestimate (~$1,305,400)
3. ✅ Appends new row to data.csv with both values (no NaN)
4. ✅ Generates updated data.png chart
5. ✅ Commits and pushes changes to main branch
6. ✅ Workflow status check passes (no NaN in last line)

## Troubleshooting

If the workflow fails:
1. Check the workflow logs in GitHub Actions
2. Verify secrets are set correctly:
   - `REDFIN_URL`
   - `ZILLOW_URL`
   - `SCRAPERAPI_KEY`
3. Check if ScraperAPI quota is exceeded
4. Verify the property URLs are still valid

## Local Testing

You can test the scraper locally:
```bash
export REDFIN_URL='https://www.redfin.com/OR/Beaverton/11342-SW-Meadowlark-Ln-97007/home/26678958'
export ZILLOW_URL='https://www.zillow.com/homedetails/11342-SW-Meadowlark-Ln-Beaverton-OR-97007/48553823_zpid/'
export SCRAPERAPI_KEY='your_key_here'

python scrape_with_premium.py
```

Expected output:
- Redfin value scraped successfully
- Zillow value scraped successfully (may retry 2-3 times)
- data.csv updated with new row
- data.png regenerated

## Next Steps

1. **Manually trigger the workflow** via GitHub UI to confirm it works
2. **Check the results** after the run completes
3. **Tomorrow's scheduled run** (5:00 AM UTC) will run automatically
4. **Monitor** the first few runs to ensure stability
