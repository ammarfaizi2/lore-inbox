Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266933AbSKOXW6>; Fri, 15 Nov 2002 18:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266940AbSKOXW6>; Fri, 15 Nov 2002 18:22:58 -0500
Received: from air-2.osdl.org ([65.172.181.6]:52144 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266933AbSKOXWz>;
	Fri, 15 Nov 2002 18:22:55 -0500
Subject: [ANNOUNCE] linux-2.5.47-dcl2
From: Stephen Hemminger <shemminger@osdl.org>
To: Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 15 Nov 2002 15:29:51 -0800
Message-Id: <1037402991.23978.221.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest release is available patches on 
        http://sourceforge.net/projects/osdldcl
More info on DCL is at http://osdl.org/projects/dcl

The kernel compiles and runs on SMP and UP systems; it passes the basic
tests but has not been extensively stress tested yet.  The LTT and LKCD
features have been tried. NUMA testing is ongoing.


linux-2.5.47-dcl2
o Fix Device Mapper			(Joe Thornber)

linux-2.5.47-osdl2
o More fixes to the megaraid driver	(Matt Domsch, Mark Haverkamp)
o Fix to LKCD block device setup	(me)
o Default ACPI to off for SMP systems	(me)
o Fix I/O errors on loop driver		(Hugh Dickins)

linux-2.5.47-dcl1
o NUMA scheduler enhancements         (Erich Focht, Michael Hohnbaum)

linux-2.5.47-osdl1
o Linux Trace Toolkit (LTT)          (Karim Yaghmour)
o Linux Kernel Crash Dumps           (Matt Robinson, LKCD team)
o   Network crash dumps              (Mohammed Abbas)
o Kprobes			     (Rusty Russell)
o Kernel Config storage              (Khalid Aziz, Randy Dunlap)
o DAC960 driver fixes                (Dave Olien)



