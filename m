Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264117AbUCZSmk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 13:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbUCZSmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 13:42:40 -0500
Received: from dhcp18-183.bio.purdue.edu ([128.210.18.183]:13953 "EHLO
	lapdog.ravenhome.net") by vger.kernel.org with ESMTP
	id S264117AbUCZSmb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 13:42:31 -0500
From: Praedor Atrebates <praedor@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: System clock speed too high - 2.6.3 kernel
Date: Fri, 26 Mar 2004 14:30:17 -0500
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403261430.18629.praedor@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

In doing a web search on system clock speeds being too high, I found entries 
describing exactly what I am experiencing in the linux-kernel list archives, 
but have not yet found a resolution.

I have Mandrake 10.0, kernel-2.6.3-7mdk installed, on an IBM Thinkpad 1412 
laptop, celeron 366, 512MB RAM.  I am finding that my system clock is ticking 
away at a rate of about 3:1 vs reality, ie, I count ~3 seconds on the system 
clock for every 1 real second.  I am running ntpd but this is unable to keep 
up with the rate of system clock passage.  

I had to slow my keyboard repeat rate _way_ down in order to be able to type 
at all as well.   The system is limited, in that I have no way to alter the 
actual system clock (in bios at any rate).  The CPU is properly identified as 
a celeron 366.  

Does anyone have any enlightenment, or a fix, to offer?  The exact same 
software setup on a desktop system, Athlon XP2700+, has no such problems.

praedor
- -- 
"George W. Bush is a deserter, an election thief, a drunk driver, a WMD 
liar and a functional illiterate. And he poops his pants." 
- --Barbara Bush, his mother
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAZITKSTapoRk9vv8RAkxyAJ45KBKN7ngdNX6qTOwSBIxEs7rfcACgl8e0
0lKo+bfaSHPcNpA+36WGCrE=
=ZdjK
-----END PGP SIGNATURE-----
