#!/bin/sh

# Create a project skeleton.


chezpmREADME() {
    cat <<END > README.md
$(pwd)
=================================================

Describe the package here...

Install
-------

### Compile from source

Use with system ChezScheme:

```sh
; git clone https://github.com/$(git config --get github.user)/$(pwd).git
; cd $(pwd)
; echo '(make-boot-file "main.boot" \'("scheme" "petite") "FIXME" "main.ss")' |
scheme -q
; mv main.boot ~/bin/
; echo '#!/bin/sh\nscheme-script main.boot' > ~/bin/$(pwd)
```

### Standalone binary distribution

The standalone binary distribution has ChezScheme shipped in.

Get the tarball at the Release page,
then add `bin/$(pwd)` and `man/$(pwd).1` to `PATH` and `MANPATH`.

### Usage

TODO

### Contributing

Fork and/or send pull requests or issues on github: https://github.com/$(git config --get github.user)/$(pwd)

### License

0BSD

END
}

# Currently support 0BSD.
# Pull requests for other licenses are welcome.
chezpmLicense() {
    cat <<END > LICENSE
Copyright (C) $(date +%Y) by $(git config --get user.name) <$(git config --get user.email)>

Permission to use, copy, modify, and/or distribute this software
for any purpose with or without fee is hereby granted.

This software is provided "as is" without express or implied warranty.

END
}

# Directory structure.
chezpmMkdir() {
    mkdir -p src
    mkdir -p bin
    mkdir -p obj
    mkdir -p man
}

# Generate startup script.
chezpmBin() {} {
    cat <<END > bin/$(pwd)
#!/bin/sh
cd "\$(dirname \$(readlink -f \$0))"
./scheme --boot ../obj/petite.boot --boot ../obj/scheme.boot \
    --program ../obj/main.boot
}

END
}

# main
chezpmMkdir
chezpmREADME
chezpmLicense
chezpmBin
