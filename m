Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbTJ3PIc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 10:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262570AbTJ3PIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 10:08:31 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:13990 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S262569AbTJ3PIa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 10:08:30 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test9 vs sound
Date: Thu, 30 Oct 2003 10:08:27 -0500
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Disposition: inline
Organization: None that appears to be detectable by casual observers
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200310301008.27871.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.58.154] at Thu, 30 Oct 2003 09:08:29 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Where can I find a step by step tutorial on installing alsa since OSS 
has been deprecated?  I've been using the shareware OSS on this mobo 
for years, the audio chipset is VIA 8233 family.  I have as much of 
it compiled into the kernel as there are checkmarks in kconfig but 
nothing soundwise is working yet.  I also put that LXD option on the 
grub line, but thats being ignored, the dmesg comment is still there.
If grub.conf wasn't where it goes, please advise on that too.

I've been booted to this for about 10 hours now, and so far sound is 
the only thing not working that I've needed.  Not all of my usb stuff 
has been exercized yet though.

So far it just plain feels good, congrats to all involved.

Mmm, the pair of warnings about the check_region call being deprecated 
are still there in the advansys driver, but it worked normally for 
amanda last night.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

