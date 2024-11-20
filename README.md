# FFmpeg

Forked and patched from https://gitlab.com/martinr92/ffmpeg to build on Apple Silicon and MacOS Sonoma.

See original repo for details.


#### Requirements

(Probably non exhaustive list)

* Xcode
* `brew install gcc`
* `brew install automake`
* `brew install zip`
* `brew install bzip2`
* `brew install pyenv`
* `brew install yasm` (not sure)
* `pyenv install 3.9.0`
* `pyenv global 3.9.0`
* `sudo ln -s /Users/<USER_NAME>/.pyenv/shims/python /usr/local/bin/python`
* `python3 -m pip install virtualenv`
* `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`
* `cargo install cargo-c`
* `rustc --version`
* `cargo --version`
* `cargo c --version`
