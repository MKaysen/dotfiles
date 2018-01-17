#
# A theme based on Steve Losh's Extravagant Prompt with vcs_info integration.
#
# Author:
#   Mikkel Kaysen <mikkel.kaysen@gmail.com>
#

# Formats:
#   %b - branchname
#   %u - unstagedstr (see below)
#   %c - stagedstr (see below)
#   %a - action (e.g. rebase-i)
#   %R - repository path
#   %S - path in the repository

function prompt_mkaysen_precmd {
  # Check for untracked files or updated submodules since vcs_info does not.
  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    branch_format="(${_prompt_mkaysen_colors[4]}%b%f) %u%c [${_prompt_mkaysen_colors[2]}●%f]"
  else
    branch_format="(${_prompt_mkaysen_colors[4]}%b%f) %u%c"
  fi

  zstyle ':vcs_info:*:prompt:*' formats "${branch_format}"

  vcs_info 'prompt'

  setopt prompt_subst
}

function prompt_mkaysen_setup {
  setopt LOCAL_OPTIONS
  unsetopt XTRACE KSH_ARRAYS
  prompt_opts=(cr percent sp subst)

  # Load required functions.
  autoload -Uz add-zsh-hook
  autoload -Uz vcs_info

  # Add hook for calling vcs_info before each command.
  add-zsh-hook precmd prompt_mkaysen_precmd

  # Use extended color pallete if available.
  if [[ $TERM = *256color* || $TERM = *rxvt* ]]; then
    _prompt_mkaysen_colors=(
      "%F{70}"  # Chartreuse3
      "%F{172}" # Orange3
      "%F{81}"  # SteelBlue1
      "%F{57}"  # BlueViolet
      "%F{135}" # MediumPurple2
      "%F{161}" # DeepPink3
    )
  else
    _prompt_mkaysen_colors=(
      "%F{green}"
      "%F{yellow}"
      "%F{blue}"
      "%F{cyan}"
      "%F{magenta}"
      "%F{red}"
    )
  fi

  local branch_format="(${_prompt_mkaysen_colors[4]}%b%f) %u%c"
  local action_format="(${_prompt_mkaysen_colors[5]}%a%f)"
  local unstaged_format="[${_prompt_mkaysen_colors[6]}●%f]"
  local staged_format="[${_prompt_mkaysen_colors[1]}●%f]"

  # Set vcs_info parameters.
  zstyle ':vcs_info:*' enable bzr git hg svn
  zstyle ':vcs_info:*:prompt:*' check-for-changes true
  zstyle ':vcs_info:*:prompt:*' unstagedstr "${unstaged_format}"
  zstyle ':vcs_info:*:prompt:*' stagedstr "${staged_format}"
  zstyle ':vcs_info:*:prompt:*' actionformats "${branch_format} ${action_format}"
  zstyle ':vcs_info:*:prompt:*' formats "${branch_format}"
  zstyle ':vcs_info:*:prompt:*' nvcsformats   ""

  # Define prompts.
  PROMPT="${_prompt_mkaysen_colors[1]}%n%f@${_prompt_mkaysen_colors[2]}%m%f ${_prompt_mkaysen_colors[3]}%c%f "'${vcs_info_msg_0_}'"
$ "
  RPROMPT=''
}

prompt_mkaysen_setup "$@"
