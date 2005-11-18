Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161274AbVKRWDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161274AbVKRWDu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 17:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161208AbVKRWDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 17:03:50 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:25519 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S1161274AbVKRWDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 17:03:49 -0500
Date: Fri, 18 Nov 2005 17:03:47 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: dvd writes truncated 3 Mbytes
To: linux-kernel@vger.kernel.org
Message-id: <200511181703.47903.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I've just tried to burn a dvd iso 4 times, 2 different brands of disks,
getting an identical but bad md5sum for all 4 writes.

K3B reports it has written 1160 or 1163 Mbytes each time, but doesn't
seem to have a problem with that.

Kernel is 2.6.14.2, without packet writing for cd/dvd turned on, but I
have one with it enabled building now.  K3B is 0.11.13, cdrecord is
2.1(dvd), groisofs is 5.21, mkisofs is 2.1-a34.  The drive is a Lite-On
DVDRW SOHW-1673S.

Has anyone else encountered a similar problem?  I've been making
good cd's all along with no problems, in this new drive, till now.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

