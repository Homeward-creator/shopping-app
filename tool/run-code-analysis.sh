#!/bin/bash
set -e

echo "Run flutter analysis"
maximum_error_count=0
maximum_warning_count=0
maximum_info_count=5

flutter analyze --write=static_code_analysis_result.txt

while [ ! -f "static_code_analysis_result.txt" ]; do sleep 1; done

error_count=$(cat "static_code_analysis_result.txt" | grep -E "\[error\]" | wc -l | grep -Eo "[0-9]+")
warning_count=$(cat "static_code_analysis_result.txt" | grep -E "\[warning\]" | wc -l | grep -Eo "[0-9]+")
info_count=$(cat "static_code_analysis_result.txt" | grep -E "\[info\]" | wc -l | grep -Eo "[0-9]+")

if [[ $error_count -gt $maximum_error_count ]]
then
  echo "Error: flutter analysis issues error-level is $error_count more than $maximum_error_count"

  exit 1
fi
if [[ $warning_count -gt $maximum_warning_count ]]
then
  echo "Error: flutter analysis issues warning-level is $warning_count more than $maximum_warning_count"

  exit 1
fi
if [[ $info_count -gt $maximum_info_count ]]
then
  echo "Error: flutter analysis issues warning-level is $info_count more than $maximum_info_count"

  exit 1
fi


exit 0
