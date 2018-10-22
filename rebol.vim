" Vim syntax file
" Language:  Rebol
" Maintainer:  Mike Williams <mrw@eandem.co.uk>
" Filenames:  *.r
" Last Change:  27th June 2002
" URL:    http://www.eandem.co.uk/mrw/vim

" Changes-by: Barry Walsh <draegtun@gmail.com>
" Last updated: 17-May-2013

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Rebol is case insensitive
syn case ignore

" As per current users documentation
if version < 600
  set isk=@,48-57,?,!,.,',+,-,*,&,\|,=,_,~
else
  setlocal isk=@,48-57,\<,\>,?,!,.,',+,-,*,&,\|,=,_,~
endif

" Yer TODO highlighter
syn keyword  rebolTodo  contained TODO

" Delimiters
syn match       rebolDelimiter  "[][(/|)]"

" Comments
syn match       rebolComment    ";.*$" contains=rebolTodo
syn match       rebolComment    "^//.*$" contains=rebolTodo
syn match       rebolComment    "[ \t]//.*$" contains=rebolTodo

" Words
syn match       rebolWord       "\a\k*"
"syn match       rebolWordPath   "[^[:space:]]/[^[:space]]"ms=s+1,me=e-1
syn match       rebolWordSet    "\a\k*\:"
syn match       rebolWordLit    "\'\k*"

" Values
" Integers
syn match       rebolInteger    "\<[+-]\=\d\+\('\d*\)*\>"
" Decimals
syn match       rebolDecimal    "[+-]\=\(\d\+\('\d*\)*\)\=[,.]\d*\(e[+-]\=\d\+\)\="
syn match       rebolDecimal    "[+-]\=\d\+\('\d*\)*\(e[+-]\=\d\+\)\="
" Time
syn match       rebolTime       "[+-]\=\(\d\+\('\d*\)*\:\)\{1,2}\d\+\('\d*\)*\([.,]\d\+\)\=\([AP]M\)\=\>"
syn match       rebolTime       "[+-]\=:\d\+\([.,]\d*\)\=\([AP]M\)\=\>"
" Dates
" DD-MMM-YY & YYYY format
syn match       rebolDate       "\d\{1,2}\([/-]\)\(Jan\|Feb\|Mar\|Apr\|May\|Jun\|Jul\|Aug\|Sep\|Oct\|Nov\|Dec\)\1\(\d\{2}\)\{1,2}\>"
" DD-month-YY & YYYY format
syn match       rebolDate       "\d\{1,2}\([/-]\)\(January\|February\|March\|April\|May\|June\|July\|August\|September\|October\|November\|December\)\1\(\d\{2}\)\{1,2}\>"
" DD-MM-YY & YY format
syn match       rebolDate       "\d\{1,2}\([/-]\)\d\{1,2}\1\(\d\{2}\)\{1,2}\>"
" YYYY-MM-YY format
syn match       rebolDate       "\d\{4}-\d\{1,2}-\d\{1,2}\>"
" DD.MM.YYYY format
syn match       rebolDate       "\d\{1,2}\.\d\{1,2}\.\d\{4}\>"
" Money
syn match       rebolMoney      "\a*\$\d\+\('\d*\)*\([,.]\d\+\)\="
" Strings
syn region      rebolString1     oneline start=+"+ skip=+\^"+ end=+"+ contains=rebolSpecialCharacter,remMarkdownCharacter
syn region      rebolString2     start=+{+ end=+}+ skip=+\^}+ contains=rebolSpecialCharacter,remMarkdownCharacter,rebolString2
" Binary
syn region      rebolBinary     start=+\d*#{+ end=+}+ contains=rebolComment
" Email
syn match       rebolEmail      "\<\k\+@\(\k\+\.\)*\k\+\>"
" File
syn match       rebolFile       "%\(\k\+/\)*\k\+[/]\=" contains=rebolSpecialCharacter
syn region      rebolFile       oneline start=+%"+ end=+"+ contains=rebolSpecialCharacter
" URLs
syn match       rebolURL        "http://\k\+\(\.\k\+\)*\(:\d\+\)\=\(/\(\k\+/\)*\(\k\+\)\=\)*"
syn match       rebolURL        "file://\k\+\(\.\k\+\)*/\(\k\+/\)*\k\+"
syn match       rebolURL        "ftp://\(\k\+:\k\+@\)\=\k\+\(\.\k\+\)*\(:\d\+\)\=/\(\k\+/\)*\k\+"
syn match       rebolURL        "mailto:\k\+\(\.\k\+\)*@\k\+\(\.\k\+\)*"
" Issues
syn match       rebolIssue      "#\(\d\+-\)*\d\+"
" Tuples
syn match       rebolTuple      "\(\d\+\.\)\{2,}"
" Characters
syn match       rebolSpecialCharacter contained "\^[^[:space:][]"
syn match       rebolSpecialCharacter contained "%\d\+"


" Operators
" Math operators
" Binary operators

" Tags
syn region      rebolTag       oneline start=+<\a+ end=+>+ contains=rebolComment


" Experiments of mine!
"syn match       rebolFuncStatement  "func\s\["

"""""""""""""""""""""""""""

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_rebol_syntax_inits")
  if version < 508
    let did_rebol_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink rebolTodo     Todo

  HiLink rebolKW Statement

  HiLink rebolOperator  Operator
  HiLink rebolLogicOperator rebolOperator
  HiLink rebolMathOperator rebolOperator
  HiLink rebolBinaryOperator rebolOperator
  HiLink rebolSpecialCharacter SpecialChar
  HiLink rebolString1  String
  HiLink rebolString2  String

  HiLink rebolNumber   Number
  HiLink rebolInteger  rebolNumber
  HiLink rebolDecimal  rebolNumber
  HiLink rebolTime     rebolNumber
  HiLink rebolDate     rebolNumber
  HiLink rebolMoney    rebolNumber
  HiLink rebolBinary   rebolNumber
  HiLink rebolEmail    String
  HiLink rebolFile     String
  HiLink rebolURL      String
  HiLink rebolIssue    rebolNumber
  HiLink rebolTuple    rebolNumber
  HiLink rebolFloat    Float
  HiLink rebolBoolean  Boolean
  HiLink rebolTag      String


  HiLink rebolComment  Comment

  HiLink rebolWord      Identifier
  HiLink rebolWordSet   Function
  HiLink rebolWordLit   String

  HiLink rebolDelimiter Delimiter

  delcommand HiLink
endif

syntax keyword rebolKW !! != !==
syntax keyword rebolKW *
syntax keyword rebolKW +
syntax keyword rebolKW - ->
syntax keyword rebolKW < <- <= <> <|
syntax keyword rebolKW = =< == => =?
syntax keyword rebolKW > >=
syntax keyword rebolKW ??
syntax keyword rebolKW about abs absolute acos action action! action? adapt add aes aliases? all also alter an and and+ and? any any-array! any-array? any-context! any-context? any-number! any-number? any-path! any-path? any-scalar! any-scalar? any-series! any-series? any-string! any-string? any-value! any-word! any-word? append append-of applique apply aqua arccosine arcsine arctangent arity-of array as as-pair ascii? asin ask assert at atan attempt
syntax keyword rebolKW back backslash backspace backtrace-index bar bar! bar? base-color beige binary! binary? bind binding-of bitset! bitset? black blank blank! blank? block! block? blue body-of both? bound? break breakpoint brick brown browse BS bugs
syntax keyword rebolKW c-break-debug c-debug-break c-debug-break-at call callgrind case catch cause-error cd chain change change-dir char! char? charset chat check checksum choose clean-path clear close coal coffee collect collect-with collect-words comment compile complement compose composeII concoct confirm construct context continue copy cos cosine CR create crimson cyan
syntax keyword rebolKW datatype! datatype? date! date? debase debug decimal! decimal? decode decode-text decode-url decode-utf16be decode-utf16le default default* deflate dehex delete delete-dir delimit deline delta-profile delta-time detab detab-file dh-compute-key dh-generate-key dh-make-key did did? difference dig-action-meta-fields dir dir? dirize divide do does dump dump-obj
syntax keyword rebolKW echo eighth either either-test elide else email! email? empty? enbase enclose encode encode-text encode-utf16be encode-utf16le encoding-of end enfix enfixed? enhex enline ensure ensure* entab entrap equal-or-lesser? equal? error! error? escape eval eval-enfix evaluate even? event! event? exclude exists? exit-rebol exp extend extract extreme-of
syntax keyword rebolKW factorial fail false fifth file! file-of file-to-local file-type? file? find find-all find-script first flatten for for-back for-each for-next for-skip forest forever form format fourth frame! frame? free free? full func function
syntax keyword rebolKW get get-console-actor-handle get-dir-actor-handle get-dns-actor-handle get-env get-event-actor-handle get-file-actor-handle get-os-browsers get-path! get-path? get-serial-actor-handle get-signal-actor-handle get-tcp-actor-handle get-udp-actor-handle get-word! get-word? gob! gob? gold gray greater-or-equal? greater? green group! group? gunzip gzip
syntax keyword rebolKW halt handle! handle? has head head-of head? help hijack hmac-sha256
syntax keyword rebolKW identify-text? identify-utf16be? identify-utf16le? identity if if-not image! image? immediate! import in in-dir index-of index? infix? inflate info info? init-debugger input insert integer! integer? intern internal! intersect invalid-utf8? invisible-eval-all issue! issue? ivory
syntax keyword rebolKW join join-all join-of
syntax keyword rebolKW khaki
syntax keyword rebolKW lambda last last? latin1? launch leaf length-of length? lesser-or-equal? lesser? LF lib library! library? license limit-usage line-of linen list-dir list-env lit-bar! lit-bar? lit-path! lit-path? lit-word! lit-word? load load-extension load-extension-helper load-native local-to-file locale lock lock-of locked? log-10 log-2 log-e logic! logic? loop lowercase ls
syntax keyword rebolKW magenta make make-date-ymdsnz make-dir make-native map map! map-each map-event map-gob-offset map? maroon match math max maximum maximum-of maybe me meta-of meth method metrics min minimum minimum-of mint mkdir mod modified? modify module module! module? modulo mold mold64 money! money? more move multiply my
syntax keyword rebolKW nand? native-assert navy negate negative? neither? net-log net-trace new-line new-line? newline newpage next nfix? nihil ninth no none nor? not not-equal? not? nothing? now NUL null null?
syntax keyword rebolKW object object! object? odd? of off offset-of offset? ok? oldrab olive on on-wake-up once-bar open open? opt or or+ or? orange
syntax keyword rebolKW pair! pair? panic panic-value papaya parse parse-accept parse-reject past? path path! path-0 path? pause pending pending? percent! percent? pewter pi pick pink poke port! port? positive? postfix? power prin print print-newline printf probe protect purple put pwd
syntax keyword rebolKW query quit quote
syntax keyword rebolKW r3-alpha-quote random rc4 read really reblue REBOL rebol.com rebolor recycle red redescribe redo reduce refinement! refinement? reflect rejoin remainder remold remove remove-each rename repeat repend replace request-dir* request-file* require-commit resolve resume return reverse reword right-bar rm round rsa rsa-make-key running?
syntax keyword rebolKW same? save say-browser scan-net-header scheme script? second select semiquote semiquoted? set set* set-env set-location-of-error set-meta set-net set-path! set-path? set-udp-multicast set-udp-ttl set-word! set-word? set? setlocale seventh sha256 shift shove sienna sign-of sign? silver sin sine single? sixth size-of size? skip skip* sky slash sleep snow something? sort source SP space spaced spec-of specialize speed? split split-path square-root stats strict-equal? strict-not-equal? struct! struct? subparse subtract suffix-of suffix? swap switch sync-invisibles sys system
syntax keyword rebolKW tab tag! tag? tail tail-of tail? take take* tan tangent teal tenth test test-rencpp-low-level-hook text! text? then third throw tighten time! time? title-of to to-binary to-bitset to-block to-char to-datatype to-date to-decimal to-email to-error to-event to-file to-function to-get-path to-get-word to-gob to-group to-hex to-image to-integer to-issue to-lit-path to-lit-word to-logic to-map to-module to-money to-object to-pair to-path to-percent to-port to-refinement to-relative-file to-set-path to-set-word to-tag to-text to-time to-tuple to-typeset to-url to-value to-vector to-word trace transcode trap trim true try tuple! tuple? type-of typechecker typeset! typeset?
syntax keyword rebolKW unbind undirize uneval union unique unless unload-extension unload-extension-helper unload-native unprotect unset unset? unspaced until until-not unwind unzip upgrade uppercase url! url? usage use
syntax keyword rebolKW value? values-of varargs! varargs? variadic? vector! vector? verify violet void void! void?
syntax keyword rebolKW wait wake-up was water what what-dir wheat while while-not white why wild word! word? words-of wrap write write-stdout
syntax keyword rebolKW xor xor+ xor?
syntax keyword rebolKW yello yellow yes
syntax keyword rebolKW zdeflate zero zero? zinflate zip
syntax match rebolKW "|>"
syntax match rebolKW "||"

let b:current_syntax = "rebol"
