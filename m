Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316070AbSFUC61>; Thu, 20 Jun 2002 22:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316089AbSFUC60>; Thu, 20 Jun 2002 22:58:26 -0400
Received: from revdns.flarg.info ([213.152.47.19]:35287 "EHLO noodles.internal")
	by vger.kernel.org with ESMTP id <S316070AbSFUC6Z>;
	Thu, 20 Jun 2002 22:58:25 -0400
Date: Fri, 21 Jun 2002 03:59:18 +0100
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.24-dj1
Message-ID: <20020621025918.GA9415@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Probably the last before I join the cabal^Wothers in Ottawa,
so it flushes everything of importance I had pending, and
resyncs with Linus' latest and greatest.

I'll try and keep up with anything that turns up during the
following week (time & network connection permitting), but
with 99% of the regulars otherwise occupied at KS/OLS,
I imagine it'll be a quiet week.


As usual,..

Patch against 2.5.24 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

Merged patch archive: http://www.codemonkey.org.uk/patches/merged/

Check http://www.codemonkey.org.uk/Linux-2.5.html before reporting
known bugs that are also in mainline.

 -- Davej.

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
