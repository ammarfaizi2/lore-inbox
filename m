Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264480AbTK0LRJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 06:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264481AbTK0LRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 06:17:09 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:29578 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S264480AbTK0LRH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 06:17:07 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: exiting X and rebooting
Date: Thu, 27 Nov 2003 06:17:03 -0500
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311270617.03654.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.54.127] at Thu, 27 Nov 2003 05:17:05 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I'm not sure what category this minor complaint falls under, but since 
its evidenced by a 2.6 kernel and not a 2.4, this seems like the 
place.

One of the things I've been meaning to mention is that if I'm running 
a 2.6 kernel, and exit X to reboot, the shell that had a cursor when 
I started X from it, no longer has a cursor when x has been stopped.  
This occurs only for 2.6 kernels, but works as usual for 2.4 kernels 
giving a big full character block for a cursor.

One can still type, and the keystrokes are echo'd properly.  But it is 
a bit un-nerving at first.  Logging clear out and back in again to 
re-init the shell doesn't help.  The cursor is gone.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

