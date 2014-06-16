use URI::Escape;
class Perl6::Documentable {
    has Str $.kind;     # type, language doc, routine, operator
    has Str @.subkinds;  # class/role/enum, sub/method, prefix/infix/...

    has Str $.name;
    has Str $.url;
    has     $.pod;
    has Bool $.pod-is-complete;
    has Str $.summary = '';

    # the Documentable that this one was extracted from, if any
    has $.origin;

    my sub english-list (*@l) {
        @l > 1
            ?? @l[0..*-2].join(', ') ~ " and @l[*-1]"
            !! ~@l[0]
    }
    method human-kind() {   # SCNR
        $.kind eq 'operator'
            ?? "@.subkinds[] operator"
            !! $.kind eq 'language'
            ?? 'language documentation'
            !! english-list @.subkinds // $.kind;
    }

    method filename() {
        $.kind eq 'operator'
            ?? "html/language/operators.html"
            !! "html/$.kind/$.name.html"
            ;
    }
    method url() {
        $!url //= $.kind eq 'operator'
            ?? "/language/operators#" ~ uri_escape("@.subkinds[] $.name".subst(/\s+/, '_', :g))
            !! "/$.kind/$.name"
            ;
    }
}
