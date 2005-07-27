Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262432AbVG0SdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbVG0SdJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 14:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVG0Sad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 14:30:33 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:30414 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S262132AbVG0S3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 14:29:25 -0400
Date: Wed, 27 Jul 2005 14:30:19 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: REALTIME-PREEMPT, mode 4 cs X, X loses.
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Message-id: <200507271430.19718.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings Ingo;

I had to back away from this patch series in order to burn some cd's 
about a week ago, the symptoms were that X got really slow, and then 
hangs, but it does rapidly respond to a ctl-alt-backspace exit.  I've 
since built and tested -28, -33, -37 & am now on -38, and all seem to 
suffer an X lockup, can't switch screens but the mouse works 
normally, when attempting to run something thats a heavy IRQ user, 
like xawtv, or k3b.  I also made about a dozen coasters while burning 
the debian-3.1 14 disk set, finally rebooting to 2.6.12.1 to finish 
the last 3 or 4.

Also, the hangs in kmail's composer are definitely worse, but I can't 
place an exact version number when this occurred other than in the 
later 51-20's on.

Ideas?  More clues from someplace?  The logs appear clean except for 
the attempt to run tvtime.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
