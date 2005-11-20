Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbVKTRCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbVKTRCx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 12:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbVKTRCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 12:02:53 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:19698 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751278AbVKTRCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 12:02:52 -0500
Date: Sun, 20 Nov 2005 12:02:50 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linux 2.6.15-rc2
In-reply-to: <200511200018.11791.gene.heskett@verizon.net>
To: linux-kernel@vger.kernel.org
Message-id: <200511201202.51123.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
 <200511200018.11791.gene.heskett@verizon.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 November 2005 00:18, Gene Heskett wrote:
>On Saturday 19 November 2005 22:40, Linus Torvalds wrote:
>>There it is (or will soon be - the tar-ball and patches are still
>>uploading, and mirroring can obviously take some time after that).
>
>First breakage report, tvtime, blue screen no audio.  Trying slightly
>different .config for next build.  My tuner (OR51132) seems to be
>permanently selected in an xconfig screen.  Dunno if thats good or bad
>ATM.

Update, I may be sticking my finger in the dike and hollering wolf or
however that old saw goes.  I've now rebooted to 3 kernels where tvtime
was known to work, but it doesn't.  Turning off the signal detection
shows that all I'm getting is some sort of digital noise.  So its time
to drag in another receiver and see if its the DISH convertor or my
pcHDTV-3000.

More later when I've done that.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

