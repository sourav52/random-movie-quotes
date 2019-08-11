RED="\033[0;31m"
GREEN="\033[0;32m"

# Mashpe API call
api_response=$(head -n1 <(curl --get "https://andruxnet-random-famous-quotes.p.mashape.com/?cat=famous&count=1" \
106   -H "X-Mashape-Key: XNFDcAdL5xmshpHjYlXGKWULC3Ltp1X6sXzjsnESUcyStc7PJZ" \
107   -H "Accept: application/json" 2> /dev/null))
quote=$(echo "${api_response}"| jq -r ".[] | .quote")
author=$(echo "${api_response}"| jq -r ".[] | .author")

local host_name="
%{$fg_bold[cyan]%}${quote}%{$reset_color%} - ${author}"

local path_string="%{$fg[cyan]%}%~%{$reset_color%}"
local prompt_string="$"
local return_status="%(?:%{$fg_bold[green]%}$prompt_string:%{$fg[red]%}$prompt_string)"

PROMPT='${host_name} $(git_custom_prompt) ${return_status} %{$reset_color%} $(git_remote_status)'
RPROMPT='%U$path_string%u'
ZSH_THEME_GIT_PROMPT_PREFIX="["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="$fg[red]✘%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="$fg[green]✔%{$reset_color%}"

git_custom_prompt() {
  local branch=$(current_branch)
  if [ -n "$branch" ]; then
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX$branch$ZSH_THEME_GIT_PROMPT_SUFFIX $(parse_git_dirty)"
  fi
}
