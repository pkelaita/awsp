#!/bin/bash

# Utility script to switch AWS profiles

sso_status() {
  local profile="$1" copy="$2"

  if [ "$copy" = "copy" ]; then
    printf "Checking SSO session..." >&2
  fi

  aws sts get-caller-identity --profile "$profile" >/dev/null 2>&1
  local is_active=$?

  if [ "$copy" = "copy" ]; then
    printf "\r\033[K" >&2
  fi

  if [ "$is_active" -eq 0 ]; then
    printf "Active"
  else
    if [ "$copy" = "copy" ]; then
      printf 'aws sso login --profile %s' "$profile" | pbcopy
      printf "Inactive (copied login command to clipboard)"
    else
      printf "Inactive"
    fi
  fi
}

if [ -z "$1" ]; then
  echo "Current AWS profile: ${AWS_PROFILE:-<none>}"
  [ -n "$AWS_PROFILE" ] && printf "SSO session: %s\n" "$(sso_status "$AWS_PROFILE" copy)"

elif [ "$1" = "ls" ] || [ "$1" = "list" ]; then
  echo "Available AWS profiles:"
  
  export -f sso_status
  aws configure list-profiles | \
    xargs -P "${AWSP_CONCURRENCY:-$(sysctl -n hw.ncpu 2>/dev/null || echo 4)}" -I {} \
      bash -c 'echo "$1|$(sso_status "$1")"' _ {} | \
    while IFS='|' read -r profile status; do
      [ "$profile" = "${AWS_PROFILE:-}" ] && echo "* $profile ($status)" || echo "  $profile ($status)"
    done

elif [ "$1" = "clear" ]; then
  unset AWS_PROFILE
  echo "AWS profile cleared."

else
  export AWS_PROFILE="$1"
  echo "Switched to AWS profile: $AWS_PROFILE"
  echo "SSO session: $(sso_status "$AWS_PROFILE" copy)"
fi
