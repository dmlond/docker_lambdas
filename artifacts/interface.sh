#!/bin/sh

if [ ! -e /var/run/docker.sock ]
then
  echo "You must volume mount /var/run/docker.sock" >&2
  exit 1
fi

if [ -z ${DELIVERY+x} ]
then
  echo "DELIVERY must be one of STDIN or ARG" >&2
  echo "  STDIN: feed event body to lambda with STDIN" >&2
  echo "  ARG: feed event body as argument to lambda at runtime" >&2
  exit 1
fi

echo $DELIVERY | grep -E '(STDIN|ARG)' > /dev/null 2>&1
if [ $? -gt 0 ]
then
  echo "DELIVERY must be one of STDIN, ARG" >&2
  echo "  STDIN: feed event body to lambda with STDIN" >&2
  echo "  ARG: feed event body as argument to lambda at runtime" >&2
  exit 1
fi

echo "
This is a base image designed to serve as an interface for a specific docker_lambda
implementation.  It sets the baseline of what is expected by implementations.
Implementations should support one or both of the two DELIVERY mechanism:
  STDIN: feed event body to lambda with STDIN
  ARG: feed event body as argument to lambda at runtime
Implementations can allow passthru ENV variables to be passed to the lambda by
prepending the variable name with PT_." >&2

for pt in `env | grep 'PT_'`
do
  ptfrom=`echo ${pt} | cut -d= -f1`
  ptto=`echo ${ptfrom} | cut -d_ -f2`
  ptval=`echo ${pt} | cut -d= -f2`
  echo "${ptfrom} passed as ${ptto}=${ptval}" >&2
done

echo "using "`docker -v`
