Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVETARt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVETARt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 20:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVETARt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 20:17:49 -0400
Received: from stokkie.demon.nl ([82.161.49.184]:56034 "HELO stokkie.net")
	by vger.kernel.org with SMTP id S261153AbVETAQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 20:16:52 -0400
Date: Fri, 20 May 2005 02:16:33 +0200 (CEST)
From: "Robert M. Stockmann" <stock@stokkie.net>
To: linux-kernel@vger.kernel.org, <techsupport@tyan.com>, <support@tyan.de>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       <gl@fenedex.nl>, <land@hetlageland.nl>, <hans@sww.nl>, <sww@sww.nl>
Subject: Tyan Opteron boards and problems with parallel ports
Message-ID: <Pine.LNX.4.44.0505200121410.10661-100000@hubble.stokkie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.3 (ftp://crashrecovery.org/pub/linux/amavis/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

To my dismay when arriving home i came to the conclusion that Tyan has 
switched off the parallel port by _default_ inside several BIOS releases 
in quite a number of her Opteron based motherboards.

This happens to be also the case with my Tyan Thunder K8W motherboard.

It also seems to a rather important issue when running a Linux 
distribution based on kernel 2.6.x on such a Tyan Opteron board.

Tyan switching off the Parallel Port is even also reported at the public
forum at amd.com :

http://forums.amd.com/lofiversion/index.php/t43260.html

Recently however when updating to the newest BIOS release for Tyan 
Opteron boards the parallel port seems to be switched on again inside 
the factory default settings. Exactly as we have seen with your Tyan 
Tomcat single Opteron CPU board.

The fact however that _all_ the various Linux distributions I have 
tested so far, both 32bit and 64bit AMD64, seem to have severe problems 
with the parallel port implementation of Tyan Opteron based boards, is 
so far _nowhere_ mentioned.

All problems of Tyan Opteron based machines silently locking up during 
installation and/or during normal operation of running Linux, both 
32bit and 64bit, without any display of kernel panic of any other 
logging method, seem to be solved when switching off the Parallel Port 
inside its BIOS.

So here my official complaint to Tyan and the Linux kernel developers 
to either make public notice of these problems, or preferably create a 
solution/workaround for this problem either in software or hardware or 
maybe inside a BIOS update.

Regards,

Robert M. Stockmann
-- 
Robert M. Stockmann - RHCE
Network Engineer - UNIX/Linux Specialist
crashrecovery.org  stock@stokkie.net

