Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265479AbUBFUBR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 15:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265673AbUBFUBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 15:01:17 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:18412 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S265479AbUBFUBL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 15:01:11 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: cdwriter /dev/hdc question
Date: Fri, 6 Feb 2004 15:01:07 -0500
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org
References: <200402050825.58623.gene.heskett@verizon.net> <4023E5AB.7070502@tmr.com>
In-Reply-To: <4023E5AB.7070502@tmr.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402061501.07857.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.53.166] at Fri, 6 Feb 2004 14:01:09 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 February 2004 14:06, Bill Davidsen wrote:
>Gene Heskett wrote:
>> Greetings;
>>
>> Running 2.6.2 atm, but for quite a while in the 2.6.x series I've
>> had a line in /var/log/messages immediately after the dmesg dump
>> indicating that dma was being disabled for /dev/hdc.
>
>I think this is bogus, in that it is silently enabled again. Ask
> hdparm!
>
>I thought that message was either going to go away or be paired with
> a similar "I didn't mean it" message if the drive is reenabled, but
> I can't quickly find the discussion.

I did, its off before I turn it back on.  Silly Q:  If there is a 
readable data disk in the drive, would it still shut it off?  I'll 
check that at the next reboot.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
