Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317848AbSFSLWK>; Wed, 19 Jun 2002 07:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317849AbSFSLWK>; Wed, 19 Jun 2002 07:22:10 -0400
Received: from revdns.flarg.info ([213.152.47.19]:1740 "EHLO noodles.internal")
	by vger.kernel.org with ESMTP id <S317848AbSFSLWJ>;
	Wed, 19 Jun 2002 07:22:09 -0400
Date: Wed, 19 Jun 2002 12:23:08 +0100
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.23-dj1
Message-ID: <20020619112308.GA11631@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keeping up to date, and getting some of the more important bits
out of the way from the pending folder.

As usual,..

Patch against 2.5.23 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

Merged patch archive: http://www.codemonkey.org.uk/patches/merged/

Check http://www.codemonkey.org.uk/Linux-2.5.html before reporting
known bugs that are also in mainline.

 -- Davej.

2.5.23-dj1
o   Small UP optimisation in the scheduler.		(James Bottomley)
o   Update x86 cpufreq scaling code.			(Dominik Brodowski)
o   Export ioremap_nocache() for modules.		(Andi Kleen)
o   Export default_wake_function() for modules.		(Benjamin LaHaise)
o   Compaq hotplug compile fixes.			(Felipe Contreras)
o   Fix migration thread for non linear numbered CPUs.	(Ingo Molnar)
o   Framebuffer updates.				(James Simmons)
o   Introduce CONFIG_ISA option for i386.		(Andi Kleen)
o   Fix bad locking in driver/ core.			(Arnd Bergmann)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
