! Copyright (C) 2013 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: assocs command-line hashtables io.encodings.utf8 io.files io.pathnames
    kernel math namespaces sequences splitting ;
IN: i18n

SYMBOL: i18n-table

: init-i18n ( -- ) ! or throw error
    script get parent-directory "i18n-table.txt" append-path utf8 file-lines
    [ "\"" split [ [ 32 > ] filter length 0 > ] filter ] map >hashtable
    i18n-table set-global
    ;
: i18n ( key-string -- display-string )
    i18n-table get ?at
    [ "( no translation found )" i18n-table get ?at drop " " glue ] unless
    ;
