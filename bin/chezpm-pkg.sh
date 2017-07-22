#!/bin/sh

# Package standalone distribution.

ChezVersion=$(scheme --version)
MachineType=$(echo '(machine-type)' | scheme -q)
# Specify ChezScheme installation prefix via `$CHEZSCHEMEPREFIX`.
# Otherwise use `/usr`.
ChezPrefix="${CHEZSCHEMEPREFIX:-/usr}"
ChezBootPath="$ChezPrefix/lib/csv$ChezVersion/$MachineType/"

# Depends on `md2man`.
chezpmMan() {
    md2man
}

# chezpmBoot '"lib/a.ss" "lib/b.ss" "main.ss"'
chezpmBoot() {
    # echo '(make-boot-file "obj/main.boot" \'("scheme" "petite") $1)' |
        scheme -q
}

chezpmCpEnv() {
    cp "$ChezPrefix"/bin/scheme obj/
    cp "$ChezBootPath"/petite.boot obj/
    cp "$ChezBootPath"/scheme.boot obj/
}

chezpmBoot $1
chezpmCpEnv
chezpmMan


