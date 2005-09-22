Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030405AbVIVPcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030405AbVIVPcW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 11:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030406AbVIVPcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 11:32:22 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:7411 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S1030405AbVIVPcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 11:32:21 -0400
Date: Thu, 22 Sep 2005 11:31:41 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linus GIT tree disappeared from http://www.kernel.org/git/?
In-reply-to: <20050922133228.GB26438@flint.arm.linux.org.uk>
To: Rolf Offermanns <roffermanns@sysgo.com>, linux-kernel@vger.kernel.org
Message-id: <200509221131.41838.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200509221514.44027.roffermanns@sysgo.com>
 <20050922133228.GB26438@flint.arm.linux.org.uk>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 September 2005 09:32, Russell King wrote:
>On Thu, Sep 22, 2005 at 03:14:43PM +0200, Rolf Offermanns wrote:
>> Maybe I am dreaming, but I could have sworn it has been there
>> yesterday...
>
>It seems that kernel.org hasn't finished updating the mirrors yet -
>and it seems to be taking hours.  Unfortunately, this has left Linus'
>public git tree in an inconsistent state.
>
>I won't speculate why stuff is so slow - that's for the kernel.org
>admins to work out.

I have made 4 passes at re-grabbing the 2.6.14-rc2 with git, and each
time it exits with an error, but the tree it grabs looks to be ok. 
Somethings a bit wonky here.

The error:

tags/v2.6.14-rc2

sent 563 bytes  received 2778 bytes  954.57 bytes/sec
total size is 779  speedup is 0.23
rsync: link_stat
"/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/info/alternates"
(in pub) failed: No such fi
le or directory (2)
rsync error: some files could not be transferred (code 23) at
main.c(812)

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

