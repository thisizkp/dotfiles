
### Nerd Font Patcher
```shell
mkdir ~/Downloads/berkeley-mono-patched && docker run --rm -v ~/Downloads/berkeley-mono-typeface/berkeley-mono/OTF:/in -v ~/Downloads/berkeley-mono-patched:/out nerdfonts/patcher
```

### Use thin strokes on MacOS
```shell
defaults write -g AppleFontSmoothing -int 0
```
