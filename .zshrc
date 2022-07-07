### Begin Antigen config

source /usr/local/share/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Plugins
antigen bundle git

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme af-magic 

# Tell Antigen that you're done.
antigen apply

### End of Antigen Config

### Begin Custom config

export EDITOR='nvim'

alias nv='nvim'

# Need too many things
. /usr/local/opt/asdf/libexec/asdf.sh
export GOPATH="$HOME/go"
export PATH="/usr/local/opt/icu4c/bin:/usr/local/opt/icu4c/sbin:$GOPATH/bin:$PATH"
export PATH="/usr/local/opt/postgresql@12/bin:$PATH"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/usr/local/opt/icu4c/lib/pkgconfig"
export LDFLAGS=-L/usr/local/opt/openssl@1.1/lib
export CPPFLAGS=-I/usr/local/opt/openssl@1.1/include

# Lazy me
export iCLOUD_DOCS='~/Library/Mobile\ Documents/com\~apple\~CloudDocs/'
export PATH="$HOME/.local/bin:$PATH"

### End custom config
