Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314047AbSEAUjq>; Wed, 1 May 2002 16:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314048AbSEAUjp>; Wed, 1 May 2002 16:39:45 -0400
Received: from revdns.flarg.info ([213.152.47.19]:63109 "EHLO noodles.internal")
	by vger.kernel.org with ESMTP id <S314047AbSEAUjp>;
	Wed, 1 May 2002 16:39:45 -0400
Date: Wed, 1 May 2002 21:36:12 +0100
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.12-dj1
Message-ID: <20020501203612.GA4167@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Back up to date against Linus. Lots of resyncing going on, still
quite a lot left to go too.

It's lost ~2MB in overall size over the last month, which isn't
bad considering quite a bit has also been going in at the same time.
The framebuffer work I'm leaving to James. Eventually it will all
disappear from my tree magically. Hopefully.

As usual,..
Patch against 2.5.12 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

Merged patch archive: http://www.codemonkey.org.uk/patches/merged/

Check http://www.codemonkey.org.uk/Linux-2.5.html before reporting
known bugs that are also in mainline.

 -- Davej.
 

2.5.12-dj1
o   Re-add dropped patch for hd.c to fix compile.
o   Give ide-scsi new style error handling.		(Doug Gilbert)
o   Fix up some broken comment delimiters.		(John Kim)
o   Add missing checks to exec_permission_light		(Alexander Viro)
o   Futex update.					(Rusty Russell)
o   Make tasklets use per-cpu.				(Rusty Russell)
o   Orinoco update.					(David Gibson)
o   DEC Lance driver endianism fix.			(Maciej W. Rozycki)
o   Export block_flushpage()				(Andrew Morton)
o   Export path_lookup()				(Paul Menage)
o   Fix invalid rdev oops in md code.			(Roman Zippel)
o   Bluetooth update.				(Maksim (Max) Krasnyanskiy)
o   opl3sa2 resource free on probe failure.		(Zwane Mwaikambo)
o   Further sonypi updates.				(Stelian Pop)
o   Make IKConfig work when CONFIG_MODULES=n		(Adrian Bunk)
o   set_bit fixups in irda code.			(Paul Mackerras)


-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
