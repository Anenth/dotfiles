#!/bin/bash


# protocol viewer
cd $HOME/code/pristine/debugger-protocol-viewer-pristine && git checkout gh-pages && ./update-protocol-json.sh && git commit -am "bump protocol"
cd $HOME/code/pristine/debugger-protocol-viewer-pristine && git pull && git push
