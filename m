Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932271AbVISAr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbVISAr1 (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 18 Sep 2005 20:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVISAr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 20:47:27 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:62937 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S932271AbVISAr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 20:47:27 -0400
Date: Sun, 18 Sep 2005 20:47:25 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Stooopid Q
To: linux-kernel@vger.kernel.org
Message-id: <200509182047.25887.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I finally got fdutils to almost work.

BUT, when was the kernels floppy.c reworked such that it needs
special patching to handle a floppy format that uses sector zero? 
There is a patch, but its for the floppy.c in 2.6.4 and thats a
vintage kernel itself today.  And it won't apply to recent kernels,
been there, done that.

That emasculates it so bad that half the vintage computer formats are
disabled.  Dumb...

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

