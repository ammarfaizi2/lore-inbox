Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbVKRWvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbVKRWvx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 17:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbVKRWvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 17:51:53 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:20949 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750779AbVKRWvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 17:51:52 -0500
Date: Fri, 18 Nov 2005 17:51:50 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: dvd writes truncated 3 Mbytes
In-reply-to: <20051118224113.GJ9488@csclub.uwaterloo.ca>
To: linux-kernel@vger.kernel.org
Message-id: <200511181751.51021.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200511181703.47903.gene.heskett@verizon.net>
 <20051118224113.GJ9488@csclub.uwaterloo.ca>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 November 2005 17:41, Lennart Sorensen wrote:
>On Fri, Nov 18, 2005 at 05:03:47PM -0500, Gene Heskett wrote:
>> I've just tried to burn a dvd iso 4 times, 2 different brands of
>> disks, getting an identical but bad md5sum for all 4 writes.
>>
>> K3B reports it has written 1160 or 1163 Mbytes each time, but doesn't
>> seem to have a problem with that.
>>
>> Kernel is 2.6.14.2, without packet writing for cd/dvd turned on, but
>> I have one with it enabled building now.  K3B is 0.11.13, cdrecord is
>> 2.1(dvd), groisofs is 5.21, mkisofs is 2.1-a34.  The drive is a
>> Lite-On DVDRW SOHW-1673S.
>>
>> Has anyone else encountered a similar problem?  I've been making
>> good cd's all along with no problems, in this new drive, till now.
>
>Seems more of an application issue than a kernel issue.

To me too.

>Does it work from the command line (could be a k3b bug after all)?

Haven't tried it, thats always been a puzzle for me.

>cdrecord with dvd support (unless prodvd version) is not worth using on
>most drives.  growisofs is great for most drives.
>
>The cdwrite mailinst list at lists.debian.org (not debian specific) is
>the best place I know to get answers to cd/dvd writing questions.

I'll post there, thanks.  Waiting on sub confirm notice now.
>
>Len Sorensen

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

