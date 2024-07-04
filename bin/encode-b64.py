#!/usr/bin/env python
# -----------------------------------------------------------------------------
"""
  Usage:

  $ encode-b64.py -f some.txt
  $ encode-b64.py -s "Some long text"

"""
# -----------------------------------------------------------------------------

import os
import sys
import base64
import getopt

# -----------------------------------------------------------------------------

__version__   = "2024.1.0"

data = """\
..."""


# -----------------------------------------------------------------------------

def base64_encode(data):

    encoded   = data.encode("utf-8")
    b64_bytes = base64.b64encode(encoded)
    encoded   = b64_bytes.decode("utf-8")

    return encoded


# -----------------------------------------------------------------------------

def usage():
    print(__doc__)


# -----------------------------------------------------------------------------

def main(argv):

    filename  = None
    text_data = None

    try:
        opts, args = getopt.getopt(argv, "f:s:vV?",
                ("file=", "string=", "help", "quiet", "verbose", "version"))
    except getopt.error as err:
        print(err)
        usage()
        return 1

    for opt, arg in opts:
        if opt in ("-?", "-h", "--help"):
            usage()
            return 0
        elif opt in ("-f", "--file"):
            filename                            = arg
        elif opt in ("-s", "--string"):
            text_data                           = arg
        elif opt in ("-v", "--verbose"):
            verbose_flg                         = True
        elif opt in ("-V", "--version"):
            print("[encode-b64]  Version: %s" % __version__)
            return 1
        else:
            usage()
            return 1

    if args:
        data = " ".join(args)

    elif filename and os.path.exists(filename):
        with open(filename, "r") as f_in:
            data   = f_in.read()[:-1]

    elif text_data and len(text_data) > 0:
        data = text_data

    output = base64_encode(data)

    print(f"str |{data}| -> |{output}|")


# -----------------------------------------------------------------------------

if __name__ == "__main__":
    main(sys.argv[1:])


# -----------------------------------------------------------------------------

