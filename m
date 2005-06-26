Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbVFZXie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVFZXie (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 19:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVFZXie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 19:38:34 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:8095 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S261664AbVFZXiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 19:38:20 -0400
Date: Sun, 26 Jun 2005 19:38:18 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [CFT:PATCH] 2/3: Check status of CTS when using flow control
In-reply-to: <20050626233706.E28598@flint.arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Cc: Russell King <rmk+lkml@arm.linux.org.uk>
Message-id: <200506261938.18690.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050626221501.GA5769@dyn-67.arm.linux.org.uk>
 <200506261826.43244.gene.heskett@verizon.net>
 <20050626233706.E28598@flint.arm.linux.org.uk>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 June 2005 18:37, Russell King wrote:
>On Sun, Jun 26, 2005 at 06:26:43PM -0400, Gene Heskett wrote:
>> On Sunday 26 June 2005 18:17, Russell King wrote:
>> >Fix bugme #4712: read the CTS status and set hw_stopped if CTS
>> >is not active.
>> >
>> >Thanks to Stefan Wolff for spotting this problem.
>>
>> This one needs to make mainline & maybe, after 3 years, I can use
>> a pl2303 to talk to an old slow coco.  Twould be very nice if that
>> fixed the lack of flow controls the connection apparently fails
>> from.
>
>Sorry, wasn't aware of the problem until recently.  Reviewing the
>code reveals that this bug has existed through many many many kernel
>series. ;(
>
Yes it has, and I may have even posted about it, but that would be a 
year plus back into ancient history Russell.  You mention another 
required patch also?  Where might it be obtained?

>Have you been able to test it?  You will need the first patch as
> well.
>
>(also, please remember I can't send you mail directly... still.)

I'm also getting bounces involving the address in the CC: line,
Russell King <rmk+lkml@arm.linux.org.uk>

While I can goto vz and add that address to the incoming whitelist, I 
doubt that would do you any good.  Looks like I need to bookmark that 
page and start using it more often.  Did I mention how bad vz sucks?  
Unforch, only game in this neck of the appalacians (hell I can't even 
spell it right), sorry.

Anyway, your domain name is now in the vz whitelist.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
