Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315595AbSFYQhv>; Tue, 25 Jun 2002 12:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315606AbSFYQhu>; Tue, 25 Jun 2002 12:37:50 -0400
Received: from revdns.flarg.info ([213.152.47.19]:24713 "EHLO noodles.internal")
	by vger.kernel.org with ESMTP id <S315595AbSFYQht>;
	Tue, 25 Jun 2002 12:37:49 -0400
Date: Tue, 25 Jun 2002 17:38:24 +0100
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.24-dj2
Message-ID: <20020625163824.GA20888@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just some small bits for now (other than 40kb of bits from 2.4),
more stuff pending will probably wait until after I get back from
KS/OLS/UKUUG conferences.

As usual,..

Patch against 2.5.24 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

Merged patch archive: http://www.codemonkey.org.uk/patches/merged/

Check http://www.codemonkey.org.uk/Linux-2.5.html before reporting
known bugs that are also in mainline.

 -- Davej.

2.5.24-dj2
o   Drop some more bad bits that were found whilst splitting.
o   Merge various changes from 2.4.19-rc1
o   More x86 cpufreq updates.				(Dominik Brodowski)
o   Fix up iounmap issues from the pageattr changes.	(Andi Kleen)
o   Small x86 microcode driver cleanup.			(Tigran Aivazian)


2.5.24-dj1
o   Fix broken config.in that made xconfig barf.
o   Drop some ISDN bits.
o   Updated SAA7110 i2c patch.				(Frank Davis)
o   Allow x86 cpufreq to be built modular.		(Dominik Brodowski)
o   Make modular builds of agpgart work again.		(Kai Germaschewski)
o   Fix MTRR compile on SMP.				(Patrick Mochel)
o   Various SCSI generic driver janitor items.		(William Stinson)
o   Fix oops in UHCI driver unload function.		(Andries Brouwer)
o   Fix various missing includes (tqueue.h & init.h).	(Adrian Bunk)
o   Make max number of CPUs compile time configurable.	(Robert Love)
o   Various pidhash cleanups.				(William Lee Irwin)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
