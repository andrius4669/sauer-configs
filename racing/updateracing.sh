#!/bin/sh

DATADIR='racing'
SRVDIR='srv'
PNAME='racing'


rsync -az --delete racing.andrius4669.org::racing "$DATADIR"

changed=0

if ! diff -s "$DATADIR/maps/rot.cfg" "$SRVDIR/rot.cfg" >/dev/null 2>&1
then
	cp -f "$DATADIR/maps/rot.cfg" "$SRVDIR/rot.cfg.new"
	mv -f "$SRVDIR/rot.cfg.new" "$SRVDIR/rot.cfg"
	changed=1
fi

if ! diff -s "$DATADIR/config/rends.cfg" "$SRVDIR/rends.cfg" >/dev/null 2>&1
then
	cp -f "$DATADIR/config/rends.cfg" "$SRVDIR/rends.cfg.new"
	mv -f "$SRVDIR/rends.cfg.new" "$SRVDIR/rends.cfg"
	changed=1
fi

if [ $changed -ne 0 ]
then
	# todo: use PID / daemontools' svc / runit' sv
	killall -q -USR1 "$PNAME"
fi
