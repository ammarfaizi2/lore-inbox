Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266629AbSIROKD>; Wed, 18 Sep 2002 10:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266954AbSIROKD>; Wed, 18 Sep 2002 10:10:03 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:5060 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S266629AbSIROKC>; Wed, 18 Sep 2002 10:10:02 -0400
Date: Wed, 18 Sep 2002 10:22:47 -0400 (EDT)
From: Rob Ransbottom <rir@attbi.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Clumsey make, README
Message-ID: <Pine.LNX.3.96.1020918101954.20879A-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After many, many kernel rebuilds for hardware additions
and replacements.  Usually on the same kernel version.
An idea forced its way into my preoccupied mind.

Why not build all the modules whether I need them or
not?  Then if I need a module in the future it is
waiting under /lib/modules.

So I am asking if a:

make all_modules

directive exists or should be added.
Anyone with the disk space might find this
convenient.  Then you could make all_modules &
make modules_install before building your kernel.

If such exists it should be mentioned in the README.


Thank you for the good software,


rob                     Live the dream.

