#!/bin/bash

die() {
 	echo >&2 "$@"
	exit 1
}

[ "$#" -eq 3 ] || die "usage: ${0} <project-id> <path-to-directory-containing git or svn repository> <result-file>"

BINDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PROJECT_ID="${1}"
WORKING_COPY="${2}"
CSV_FILE="${3}"
GIT_DIR="${WORKING_COPY}/.git"
SVN_DIR="${WORKING_COPY}/.svn"

if [[ -e "${GIT_DIR}" ]] ; then
	echo "The working copy found in ${WORKING_COPY} is a GIT repository"
	"${BINDIR}"/git-csv.sh "${PROJECT_ID}" "${WORKING_COPY}" "${CSV_FILE}"
fi

if [[ -e "${SVN_DIR}" ]] ; then
	echo "The working copy found in ${WORKING_COPY} is a SVN repository"
	"${BINDIR}"/svn-csv.sh "${PROJECT_ID}" "${WORKING_COPY}" "${CSV_FILE}"
fi
