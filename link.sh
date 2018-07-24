#!/bin/sh

set -eux

# Go to repository.
cd $(dirname $0)

dotfiles=$(find $(pwd) -name '.*' -a ! -name '.git' -a -type f)
for dot in ${dotfiles}
do
    base=$(basename ${dot})
    if [ -e ~/${base} ]
    then
	mv ~/${base} ~/${base}.bak
    fi
    ln -si ${dot} ~
done
