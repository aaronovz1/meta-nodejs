inherit npm-base

B="${S}"

NPM_INSTALL ?= ""
NPM_INSTALL_FLAGS ?= ""
NPM_AUDIT_FLAGS ?= ""

do_npm_install() {
    cd ${S}
    oe_runnpm ${NPM_INSTALL_FLAGS} install ${NPM_INSTALL}
}

do_npm_shrinkwrap() {
    cd ${S}
    oe_runnpm shrinkwrap
}

do_npm_dedupe() {
    cd ${S}
    oe_runnpm dedupe
}

do_npm_audit() {
    cd ${S}
    oe_runnpm audit fix ${NPM_AUDIT_FLAGS}
}

#
# npm causes unavoidable host-user-contaminated QA warnings for debug packages
#
INSANE_SKIP_${PN}-dbg += " host-user-contaminated"

addtask npm_install after do_compile before do_npm_dedupe
addtask npm_shrinkwrap after do_npm_install before do_npm_dedupe
addtask npm_dedupe after do_npm_shrinkwrap before do_install
addtask npm_audit after do_npm_shrinkwrap before do_npm_dedupe
