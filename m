Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262526AbULDD1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbULDD1a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 22:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbULDD1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 22:27:30 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:7902 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S262526AbULDD1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 22:27:24 -0500
Date: Sat, 4 Dec 2004 04:27:23 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: kernel CVS is malfunctioning
Message-ID: <20041204032723.GX32635@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel CVS seems screwed. cvsps -x --bkcvs tells there are 2
checkins.

cvsps -x for days showed this as the last checkin.

WARNING: non-increasing dates in encountered patchset members
WARNING: non-increasing dates in encountered patchset members
WARNING: non-increasing dates in encountered patchset members
WARNING: non-increasing dates in encountered patchset members
WARNING: non-increasing dates in encountered patchset members
WARNING: non-increasing dates in encountered patchset members
WARNING: non-increasing dates in encountered patchset members
WARNING: non-increasing dates in encountered patchset members
WARNING: non-increasing dates in encountered patchset members
WARNING: non-increasing dates in encountered patchset members
WARNING: non-increasing dates in encountered patchset members
[..]
---------------------
PatchSet 81424
Date: 1970/01/01 01:33:24
Author: zwane
Branch: HEAD
Tag: (none)
Log:
x86: move PIT code to timer_pit

(Logical change 1.21009)

Members:
        arch/i386/kernel/i8259.c:1.35->1.36
        arch/i386/kernel/timers/timer_pit.c:1.14->1.15
        include/asm-i386/timer.h:1.15->1.16

(see the Date tag too)

Perhaps I'm the only user, I use it on a daily basis, it worked fine
until a few days ago.
