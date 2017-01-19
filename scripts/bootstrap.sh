#!/bin/sh

#------------------------------------------------------------------------------#
#------------------------------ Bootstrap script ------------------------------#
#------------------------------------------------------------------------------#

#------------------------------ Global variables ------------------------------#
DOTFILES_ROOT="$(pwd -P $0)"
BACKUP_DIR="$HOME/.backup"
ZSHENV="$DOTFILES_ROOT/zsh/zshenv"

#---------------------------- Make backup directory ---------------------------#
backup_dir () {
  mkdir -p $BACKUP_DIR
}

#------------------------------- Print functions ------------------------------#
print_info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

print_user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

print_success () {
  printf "\r  [ \033[00;32mOK\033[0m ] $1\n"
}

print_fail () {
  printf "\r  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

#-------------------------------- Git functions -------------------------------#
setup_gitconfig () {
  print_info 'setup gitconfig'
  # if there is no user.email, we'll assume it's a new machine/setup and ask it
  if [ -z "$(git config --global --get user.email)" ]; then
    print_user ' - What is your github author name?'
    read -r user_name
    print_user ' - What is your github author email?'
    read -r user_email

    git config --global user.name $user_name
    git config --global user.email $user_email
  elif [ "$(git config --global --get dotfiles.managed)" != "true" ]; then
    # if user.email exists, let's check for dotfiles.managed config. If it is
    # not true, we'll backup the gitconfig file and set previous user.email and
    # user.name in the new one
    backup_dir
    user_name="$(git config --global --get user.name)"
    user_email="$(git config --global --get user.email)"
    mv $HOME/.gitconfig $BACKUP_DIR
    print_success "moved $HOME/.gitconfig to $BACKUP_DIR/.gitconfig"
    git config --global user.name $user_name
    git config --global user.email $user_email
  else
    # otherwise this gitconfig was already made by the dotfiles
    print_info "already managed by dotfiles"
  fi
  # include the gitconfig.local file
  git config --global include.path $HOME/.gitconfig.local
  # finally make git knows this is a managed config already, preventing later
  # overrides by this script
  git config --global dotfiles.managed true
  print_success 'gitconfig'
}

#-------------------------- ZSH environment functions -------------------------#
setup_zshenv () {
  print_info 'setup zshenv'
  sed "s|sed_dotfiles_root|$DOTFILES_ROOT|g" < $ZSHENV > $HOME/.zshenv
  print_success 'zshenv'
}

#------------------------------- Link functions -------------------------------#
link_file() {
  if [ -e $2 ]; then
    if [ $1 -ef $2 ]; then
      print_success "skipped $1"
      return 0
    else
      backup_dir
      mv $2 $BACKUP_DIR
      print_success "moved $2 to $BACKUP_DIR"
    fi
  fi
  ln -sf $1 $2
  print_success "linked $1 to $2"
}

#------------------------- Symlink dotfiles functions -------------------------#
install_dotfiles () {
  print_info 'installing dotfiles'
  find -H $DOTFILES_ROOT -maxdepth 2 -name '*.symlink' -not -path '*.git*' |
    while read -r src; do
      dst="$HOME/.$(basename $src .symlink)"
      link_file $src $dst
    done
}

setup_gitconfig
setup_zshenv
install_dotfiles
