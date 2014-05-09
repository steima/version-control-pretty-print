#!/bin/bash

die() {
 	echo >&2 "$@"
	exit 1
}

[ "$#" -eq 3 ] || die "usage: ${0} <project-id> <path-to-directory-containing git or svn repository> <result-file>"

PROJECT_ID="${1}"
WORKING_COPY="${2}"
GIT_DIR="${WORKING_COPY}/.git"
CSV_FILE="${3}"

[ -e "${GIT_DIR}" ] || die "The working copy ${WORKING_COPY} is not a valid GIT repository"

cd "${WORKING_COPY}"
git log --pretty=format:"${PROJECT_ID},%ae,%ai" > "${CSV_FILE}"
