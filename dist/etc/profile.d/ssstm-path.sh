# shellcheck shell=sh

# Expand $PATH to include the ssstm binaries
ssstm_bin_path="/opt/ssstm/bin"
if [ -n "${PATH##*${ssstm_bin_path}}" ] && [ -n "${PATH##*${ssstm_bin_path}:*}" ]; then
    export PATH="$PATH:${ssstm_bin_path}"
fi
