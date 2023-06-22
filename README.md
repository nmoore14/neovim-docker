# NeoVim Docker

- Clone the repo
- Run the following command from inside your local version to build the image:
`docker build -t neovim-docker:v1`
- Add the following to your zsh/bash config to use as an ide in whatever directory you are in
```
neovimDocker() {
    docker run \
        --rm -it \
        -v $(pwd):/mnt/workspace \
        -v $HOME/.config/nvim:/home/neovim/.config/nvim \
        neovim-docker:v1 \
        "$@"
       }
alias nd="neovimDocker"
```
