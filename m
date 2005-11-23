Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbVKWEmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbVKWEmP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 23:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbVKWEmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 23:42:15 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:32081 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S932515AbVKWEmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 23:42:14 -0500
Date: Tue, 22 Nov 2005 23:42:12 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linux 2.6.15-rc2
In-reply-to: <Pine.LNX.4.64.0511221642310.13959@g5.osdl.org>
To: linux-kernel@vger.kernel.org
Message-id: <200511222342.13047.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
 <20051122150002.26adf913.akpm@osdl.org>
 <Pine.LNX.4.64.0511221642310.13959@g5.osdl.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 November 2005 19:50, Linus Torvalds wrote:
>On Tue, 22 Nov 2005, Andrew Morton wrote:
>> Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu> wrote:
>> >                 from fs/compat_ioctl.c:52,
>> >                  from arch/x86_64/ia32/ia32_ioctl.c:14:
>> > include/linux/ext3_fs.h: In function 'ext3_raw_inode':
>> > include/linux/ext3_fs.h:696: error: dereferencing pointer to
>> > incomplete type
>>
>> This might help?
>
>Why does it happen at all, though? And why aren't more people reporting
>this? Something strange going on.

What would I have to turn on to get that one built?  Its not building at
all with my current .config.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

