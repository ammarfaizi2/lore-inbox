Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276914AbRJCI2W>; Wed, 3 Oct 2001 04:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276915AbRJCI2M>; Wed, 3 Oct 2001 04:28:12 -0400
Received: from web10406.mail.yahoo.com ([216.136.130.98]:60167 "HELO
	web10406.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S276914AbRJCI15>; Wed, 3 Oct 2001 04:27:57 -0400
Message-ID: <20011003082825.82430.qmail@web10406.mail.yahoo.com>
Date: Wed, 3 Oct 2001 18:28:25 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Is there a bug in 2.4.x that gcc-3.0.1 trigger it?
To: kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Further to my last post about linux-2.4.9-acx and
2.4.9 up, the problem is if the kernel compiled with
gcc-3.0.1 and run Limewire (a java program) the system
gave segmentation fault. If re-run for the second
time, the system quickly reboots itself. (any other
programs seem to be normal even some simple java
program, not relating or using the internet is running
as normal, I test many applets in mozilla, but if I
test for example the chat applet from yahoo site, it
hangs (not self-reboot)

I think there is some code in these kernel causing the
bug. Strange enough that if I use communicator 4.7
(and its built in java VM, no problem when running
applet chat.yahoo.com).

Today I made 2.2.19 kernel with gcc-3.0.1 and untill
now everything is ok. Limewire runs as normal.

I hope that some one would discover what is wrong with
2.4.9x or where to blame the problem . in my computer
(intel celeron 400Mh) gcc-3.0.1 generates code that is
faster than gcc-2.95.3.

Cheers,





=====
S.KIEU

http://travel.yahoo.com.au - Yahoo! Travel
- Got Itchy feet? Get inspired!
