Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130211AbRB1PVc>; Wed, 28 Feb 2001 10:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130227AbRB1PVM>; Wed, 28 Feb 2001 10:21:12 -0500
Received: from wit393115.student.utwente.nl ([130.89.235.25]:7172 "HELO
	wit393115.student.utwente.nl") by vger.kernel.org with SMTP
	id <S130225AbRB1PVD>; Wed, 28 Feb 2001 10:21:03 -0500
Date: Wed, 28 Feb 2001 16:19:02 +0100 (CET)
From: Wouter Schoot <wschoot@dds.nl>
X-X-Sender: <root@wit393115.student.utwente.nl>
To: <mec@shout.net>
cc: <linux-kernel@vger.kernel.org>
Subject: AC6 crash
Message-ID: <Pine.LNX.4.33.0102281617410.633-100000@wit393115.student.utwente.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I entered make menuconfig with 2.4.2 patched with AC6.
I run 2.4.2 AC2 at the moment, and unpacked 2.4.2 and AC6 from the scratch


Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> scripts/Menuconfig: MCmenu0: command not found

Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and
which menu you were trying to enter when this error occurred.

make: *** [menuconfig] Error 1
root@ascent:/usr/src/linux#

It doesn't like me :(

Wouter Schoot
-
wschoot@dds.nl - UIN# 42109851

