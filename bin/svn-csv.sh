#!/bin/bash

die() {
 	echo >&2 "$@"
	exit 1
}

[ "$#" -eq 3 ] || die "usage: ${0} <project-id> <path-to-directory-containing git or svn repository> <result-file>"

PROJECT_ID="${1}"
WORKING_COPY="${2}"
SVN_DIR="${WORKING_COPY}/.svn"
CSV_FILE="${3}"

BINDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

[ -e "${SVN_DIR}" ] || die "The working copy ${WORKING_COPY} is not a valid SVN repository"

cd "${WORKING_COPY}"
svn update
svn log --xml > tmp.xml
xmlsh "${BINDIR}/svn-xml-csv.xsh"
rm tmp.xml

sed -i -e "s/^/${PROJECT_ID},/" tmp.csv

mv tmp.csv "${CSV_FILE}"
