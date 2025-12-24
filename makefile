feature ?= shopping_feature

# use to clean and get packages
reset/project: project/cleanup project/install/package 

project/install/package:
	flutter pub get

project/cleanup: 
	flutter clean

analysis/run:
	bash ./tool/run-code-analysis.sh

# make l10n/generate or make l10n/generate feature=<folder_name>
l10n/generate:
	flutter gen-l10n --arb-dir lib/features/${feature}/configs/content --output-dir=lib/features/${feature}/configs/content --no-synthetic-package --no-nullable-getter