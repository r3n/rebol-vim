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
"syn match       rebolDelimiter  "[][(/|)]"

" Comments
syn match       rebolComment    ";.*$" contains=rebolTodo

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
syn region      rebolString1     oneline start=+"+ skip=+\^"+ end=+"+ contains=rebolSpecialCharacter
syn region      rebolString2     start=+{+ end=+}+ skip=+\^}+ contains=rebolSpecialCharacter,rebolString2
" Binary
syn region      rebolBinary     start=+\d*#{+ end=+}+ contains=rebolComment
" Email
syn match       rebolEmail      "\<\k\+@\(\k\+\.\)*\k\+\>"
" File
syn match       rebolFile       "%/\=\(\k\+/\)*\k\+[/]\=" contains=rebolSpecialCharacter
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

" if '<' was a keyword </tag> wouldn't be recognized
syntax match rebolKW "<"
" Tags
syn region      rebolTag       oneline start=+<\a+ end=+>+
syn region      rebolTag       oneline start=+</+ end=+>+



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

" GENERATED BY MAKE-WORD-LIST.REB
syntax keyword rebolKW != !==
syntax keyword rebolKW * **
syntax keyword rebolKW +
syntax keyword rebolKW - -- ->
syntax keyword rebolKW <- <= <> <|
syntax keyword rebolKW = =< == === => =?
syntax keyword rebolKW > >=
syntax keyword rebolKW ??
syntax keyword rebolKW about abs absolute acos action! action? adapt add aes-key aes-stream aliases? all also alter an and and+ and? any any-array! any-array? any-context! any-context? any-number! any-number? any-path! any-path? any-scalar! any-scalar? any-series! any-series? any-string! any-string? any-value! any-word! any-word? api-transient append applique apply aqua arccosine arcsine arctangent array as as-pair ascii? asin ask assert at atan attempt
syntax keyword rebolKW back backslash backspace backtrace base-color beige binary! binary? bind binding-of bitset! bitset? black blank blank! blank? block! block? blockify blue body-of both? bound? break breakpoint breakpoint* brick brown browse BS bugs builtin-extensions
syntax keyword rebolKW c-break-debug c-debug-break c-debug-break-at c-debug-tick call call* call-internal* callgrind case catch cause-error cd chain change change-dir char! char? charset chat check checksum clean-path clear close coal coffee collect collect* collect*-with collect-lines collect-text collect-words comment compile complement compose confirm console console! const const? construct contains-newline context continue copy cos cosine count-down count-up CR create crimson custom! cyan cycle
syntax keyword rebolKW datatype! datatype? date! date? debase debug decimal! decimal? decode decode-text decode-url decode-utf16be decode-utf16le default default* deflate dehex delete delete-dir delimit deline delta-profile delta-time dequote description-of detab detab-file devoid dh-compute-key dh-generate-key dh-make-key did did? difference dig-action-meta-fields dir? dirize divide do does dump dump-to-newline dumps
syntax keyword rebolKW eighth either either-match elide else email! email? empty? enbase enblock enclose encode encode-text encode-utf16be encode-utf16le encoding-of enfix enfixed enfixed? engroup enhex enline ensure entab entrap equal-or-lesser? equal? error! error? escape eval eval-all evaluate even? event! event? every exclude exists? exit-rebol exp exports ext-console-impl extend extract extreme-of
syntax keyword rebolKW factorial fail false fifth file! file-of file-to-local file-type? file? find find-all find-last find-reverse find-script first flatten for for-back for-each for-next for-skip forest forever form format fourth frame! frame? free free? full func function
syntax keyword rebolKW generate generic get get-block! get-block? get-current-exec get-dns-actor-handle get-env get-file-actor-handle get-group! get-group? get-os-browsers get-path! get-path? get-tcp-actor-handle get-udp-actor-handle get-word! get-word? getify gob! gob? gold gray greater-or-equal? greater? green group! group? groupify gunzip gzip
syntax keyword rebolKW halt handle! handle? head head-of head? help hijack hmac-sha256
syntax keyword rebolKW identify-text? identify-utf16be? identify-utf16le? identity if image! image? immediate! import in in-dir index-of index? inflate info info? input input-lines insert integer! integer? intern internal! interrupt intersect into invalid-utf8? issue! issue? iterate iterate-back iterate-next iterate-skip ivory
syntax keyword rebolKW join join-all join-of
syntax keyword rebolKW khaki
syntax keyword rebolKW lambda last last? latin1? launch leaf length-of length? lesser-or-equal? lesser? LF lib library! library? license limit-usage line-of linen list-dir list-env lit lit-path! lit-path? lit-word! lit-word? literal load load-extension load-module local-to-file locale locals lock lock-of locked? log-10 log-2 log-e logic! logic? loop lowercase ls
syntax keyword rebolKW magenta make make-date-ymdsnz make-dir make-native map map! map-each map? maroon match match? matched matches math max maximum maximum-of maybe me meta-of meth method metrics min minimum minimum-of mint mkdir mod modified? modify module module! module? modulo mold mold64 money! money? more move multiply mutable mutable? my
syntax keyword rebolKW n-shot nand? native-assert navy negate negative? neither? net-log net-trace new-line new-line? newline newlined newpage next nihil ninth no none nor? not not-equal? not? nothing? now NUL null null? nulled
syntax keyword rebolKW object! object? odd? of off offset-of offset? ok? oldrab olive on on-wake-up once-bar oneshot open open? opt or or+ or? orange
syntax keyword rebolKW pair! pair? panic panic-value papaya parse parse-accept parse-reject past? path path! path-0 path? pause pending pending? percent! percent? pewter pi pick pink poke port! port? positive? power prin print printf probe protect purple put pwd
syntax keyword rebolKW query quit quote quoted! quoted?
syntax keyword rebolKW r3-alpha-lit random rc4-key rc4-stream read read-lines read-stdin really reblue REBOL rebol.com rebolor recycle red redescribe redo reduce refinement! refinement? reflect register-network-device register-stdio-device rejoin remainder remold remove remove-each rename repeat repend replace request-dir* request-file* require-commit reskinned resolve RESUME return reverse reword rm round rsa rsa-make-key running?
syntax keyword rebolKW same? save scan-net-header scheme script? second select semiquoted? set set* set-block! set-block? set-env set-group! set-group? set-location-of-error set-meta set-net set-path! set-path? set-udp-multicast set-udp-ttl set-word! set-word? set? setify setlocale seventh sha256 shift shove sienna sign-of sign? silver sin sine single? sixth size-of size? skinner-return-helper skip skip* sky slash sleep snow so something? sort source SP space spaced spaced-text spec-of specialize speed? split split-path square-root stats steal step stop strict-equal? strict-not-equal? struct! struct? subparse subtract suffix-of suffix? summarize-obj swap switch sym-block! sym-block? sym-group! sym-group? sym-path! sym-path? sym-word! sym-word? symify sync-invisibles sys system
syntax keyword rebolKW tab tag! tag? tail tail-of tail? take take* tan tangent teal tenth test-librebol test-rencpp-low-level-hook text! text? then third throw time! time? to to-binary to-bitset to-block to-char to-datatype to-date to-decimal to-email to-error to-event to-file to-function to-get-path to-get-word to-gob to-group to-hex to-image to-integer to-issue to-lit-path to-lit-word to-logic to-map to-module to-money to-object to-pair to-path to-percent to-port to-refinement to-relative-file to-set-path to-set-word to-tag to-text to-time to-tuple to-typeset to-url to-value to-vector to-word trace transcode trap trim true try tuple! tuple? tweak type-of typechecker typeset! typeset?
syntax keyword rebolKW unbind undirize uneval union unique unless unload-extension unprotect unquote unset unset? unspaced unspaced-text until unwind unzip upgrade uppercase upshot url! url? usage use
syntax keyword rebolKW value? values-of varargs! varargs? variadic? vector! vector? verify violet void void! void? voidify
syntax keyword rebolKW wait wake-up was water what what-dir wheat while white why wild word! word? words-of wrap write write-stdout
syntax keyword rebolKW xor xor+ xor?
syntax keyword rebolKW yello yellow yes
syntax keyword rebolKW zdeflate zero zero? zinflate zip
syntax match rebolKW "|"
syntax match rebolKW "|>"
syntax match rebolKW "||"
syntax match rebolKW "|||"
let b:current_syntax = "rebol"
