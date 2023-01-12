tooldir=$(dirname "$0")
. ${tooldir}/mjit_archflag.sh
parse_arch_flags "${UNIVERSAL_ARCHNAMES}" ${ARCH_FLAG}
test "${Q}" = @ || set -x
echo '#ifndef RUBY_MJIT_CONFIG_H'
echo '#define RUBY_MJIT_CONFIG_H 1'
echo
sep=
echo '#ifdef LOAD_RELATIVE'
quote MJIT_HEADER_INSTALL_DIR "/${MJIT_HEADER_INSTALL_DIR}"
echo '#else'
quote MJIT_HEADER_INSTALL_DIR "${rubyarchhdrdir}"
echo '#endif'
quote MJIT_MIN_HEADER_NAME "${MJIT_MIN_HEADER_NAME}"
sep=,
quote "MJIT_CC_COMMON  " ${MJIT_CC}
quote "MJIT_CFLAGS      MJIT_ARCHFLAG" ${MJIT_CFLAGS}
quote "MJIT_OPTFLAGS   " ${MJIT_OPTFLAGS}
quote "MJIT_DEBUGFLAGS " ${MJIT_DEBUGFLAGS}
quote "MJIT_LDSHARED   " ${MJIT_LDSHARED}
quote "MJIT_DLDFLAGS    MJIT_ARCHFLAG" ${MJIT_DLDFLAGS}
quote "MJIT_LIBS       " ${LIBRUBYARG_SHARED}
quote "PRELOADENV       \"${PRELOADENV}\""
indent=${archs:+'  '}
define_arch_flags
echo
echo '#endif /* RUBY_MJIT_CONFIG_H */'
