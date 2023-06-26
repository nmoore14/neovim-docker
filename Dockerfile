# syntax=docker/dockerfile:1
FROM alpine:latest as builder

WORKDIR /mnt/build/ctags

RUN apk --no-cache add \
	git \
	xfce4-dev-tools \
	build-base

RUN \
	git clone https://github.com/universal-ctags/ctags \
	&& cd ctags \
	&& ./autogen.sh \
	&& ./configure --prefix=/usr/local \
	&& make \
	&& make install

FROM alpine:latest

LABEL \
  maintainer="nickmoore_1@live.com" \
  url.github="https://github.com/nmoore14/neovim-docker"

ENV \
  UID="1000" \
  GID="1000" \
  UNAME="neovim" \
  GNAME="neovim" \
  SHELL="/bin/zsh" \
  WORKSPACE="/mnt/workspace" \
  NVIM_CONFIG="/home/neovim/.config/nvim" \
  NVIM_PCK="/home/neovim/.local/share/nvim/site/pack" \
  ENV_DIR="/home/neovim/.local/share/vendorvenv" \
  NVIM_PROVIDER_PYLIB="python3_neovim_provider" \
  PATH="/home/neovim/.local/bin:${PATH}"


RUN apk add git fzf zsh neovim neovim-doc curl sudo su-exec shadow --update
RUN apk add wget gzip ripgrep nodejs npm --update	
  # create user
RUN addgroup "${GNAME}" \
  && adduser -D -G "${GNAME}" -g "" -s "${SHELL}" "${UNAME}" \
  && echo "${UNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# pre-download lazy.nvim
RUN git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable /root/.local/share/nvim/lazy/lazy.nvim

# copy project files
COPY .zshrc .zshrc
# COPY nvim .config/nvim

# copy these hidden folders during development for faster
# loading of lazy.nvim, mason, and treesitter
# COPY .cache /root/.cache
# COPY .local /root/.local

COPY entrypoint.sh /usr/local/bin/

VOLUME "${WORKSPACE}"
VOLUME "${NVIM_CONFIG}"

# ENTRYPOINT ["sh", "/usr/local/bin/entrypoint.sh"]
