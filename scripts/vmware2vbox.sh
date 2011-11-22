#!/bin/bash

set -e
set -u

PATCHBIN=${PATCHBIN:='/usr/bin/patch'}
OSSLBIN=${OSSLBIN:='/usr/bin/openssl'}
SEDBIN=${SEDBIN:='/usr/bin/sed'}
OVFTOOL=${OVFTOOL:='/opt/vmware/ovftool/ovftool'}
OVFOPS=${OVFOPS:='-dm=monolithicSparse'}
OSVER=${OSVER:='5.7'}
OSDIST=${OSDIST:='centos'}
PUPPETVER=${PUPPETVER:='pe-2.0.0'}
VWNAME=${OSDIST}-${OSVER}-${PUPPETVER}-vmware
VBNAME=${OSDIST}-${OSVER}-${PUPPETVER}-vbox

${OVFTOOL} ${OVFOPS} ../${VWNAME}/${VWNAME}.vmx ${PWD}/${VBNAME}.ovf

OVFFILE=`ls ${PWD} | grep \.ovf$`
SED_ID='s/ovf:id="vm"/ovf:id="Puppet Training"/'
${SEDBIN} -i -e "$SED_ID" ${OVFFILE}

MFFILE=`ls ${PWD} | grep \.mf$`
NEWSHA=`${OSSLBIN} sha1 ${OVFFILE}`
SED_SHA="s/SHA1(${VBNAME}.ovf.*/${NEWSHA}/"
${SEDBIN} -i -e "$SED_SHA" ${MFFILE}

rm -f *-e
