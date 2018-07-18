#!/bin/sh

set -u

# Go to repository.
cd $(dirname $0)

dotfiles=$(find $(pwd) -name '.*' -a ! -name '.git')
for dot in ${dotfiles}
do
    ln -si ${dot} ~
done
