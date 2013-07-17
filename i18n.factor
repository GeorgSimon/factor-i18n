USING: accessors assocs command-line continuations hashtables
    io io.encodings.utf8 io.files io.pathnames
    kernel math namespaces sequences splitting ;
IN: i18n

SYMBOL: i18n-table

: i18n-table-path ( -- path )
    script get parent-directory "i18n-table.txt" append-path
    ;
: lines>string-arrays ( lines -- string-arrays )
    [ "\"" split [ [ 32 > ] filter length 0 > ] filter ] map
    ;
: init-i18n ( -- )

    i18n-table-path

    [ utf8 file-lines ]
    [ message>> write " : " write print
      "Strings will not be translated" print flush
      { } ]
    recover

    lines>string-arrays

    [ >hashtable ]
    [ 2drop "Syntax error in " write i18n-table-path print flush { } ]
    recover

    i18n-table set-global
    ;
: i18n ( key-string -- display-string )
    i18n-table get ?at
    [ "No translation found : " i18n-table get ?at drop write
      dup print flush ]
    unless
    ;
