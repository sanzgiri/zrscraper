#!/bin/bash
echo "Checking latest workflow run..."
gh run list --workflow=real-estate-scrape.yml --limit 1 --json status,conclusion,createdAt,displayTitle

echo -e "\nTo watch the latest run in real-time, use:"
echo "gh run watch \$(gh run list --workflow=real-estate-scrape.yml --limit 1 --json databaseId --jq '.[0].databaseId')"
