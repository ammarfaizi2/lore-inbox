Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262880AbVCXRYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262880AbVCXRYD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 12:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263141AbVCXRYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 12:24:03 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:55475 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S262880AbVCXRYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 12:24:00 -0500
Date: Thu, 24 Mar 2005 12:23:58 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: vfat broken in 2.6.10?
In-reply-to: <87fyyl3war.fsf@devron.myhome.or.jp>
To: linux-kernel@vger.kernel.org
Message-id: <200503241223.58853.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <4241E3EA.4080501@comcast.net> <87fyyl3war.fsf@devron.myhome.or.jp>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 March 2005 10:20, OGAWA Hirofumi wrote:
>John Richard Moser <nigelenki@comcast.net> writes:
>> It appears dosfsck may not be working quite right.  I've taken
>> this into account, hence the second pass after each fsck.  This is
>> either a dosfsck issue, a usb-storage issue for the PNY compact
>> flash drive, or an issue with vfat itself.
>>
>> So either LKML needs to fix the drivers, or Ubuntu needs to
>> upgrade/fix dosfsck or some patch they've applied to the kernel.
>
>Can you try
> http://user.parknet.co.jp/hirofumi/tmp/fatfsprogs.tar.bz2, or most
> recently released dosfstools (2.11 or later)?

Humm, not available via yum according to yum, and mine is 
2.8.something.

Has this not made it to the fc2 repo's yet?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
