<h1 align="center">
  <img alt="cgapp logo" src="logo.svg" width="224px"/>
</h1>
<p align="center">Basic implementation of the best programming language - <b>Brainfuck</b>, written in <b>COBOL</b> </p>

<p align="center"><img src="https://img.shields.io/badge/COBOL-GNU-9cf?style=for-the-badge&logo=gnu" alt="cobol version" />&nbsp;<img src="https://img.shields.io/badge/license-gpl3-red?style=for-the-badge&logo=none" alt="license" /></p>

## ⚡️ Quick start
Start the executable of this file simply by using
```bash
./main
```

After starting the interpreter expects an input - the program written in brainfuck. Pressing enter will start the exection.

## 🏗️ Building

For building the program first install GNU COBOL:
### Installing
Install dependencies:
```bash
sudo apt-get -y install build-essential libgmp-dev libdb-dev libncurses-dev \
  libcjson-dev libxml2-dev
```
Download the source code from the website and extract it.
From within the downloaded folder, run:
```bash
make
sudo make install
```
After installation, add the following line to the `~/.bashrc` file.
```bash
export LD_LIBRARY_PATH=${LOAD_LIBRARY_PATH}:/usr/local/lib
```
### Building
After installing GNU COBOL this program can be build by using the following command:
```bash
cobc -x main.cbl
```

### Debuging
For debuging I suggest the VS-Code extension called "COBOL debugger - Oleg Kunitsyn".
Info: for this extension to work, it is required to have the GNU debugger (gdb) installed.