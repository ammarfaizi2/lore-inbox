Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751574AbWB0Gw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbWB0Gw5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 01:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbWB0Gw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 01:52:57 -0500
Received: from mail.dvmed.net ([216.237.124.58]:702 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751085AbWB0Gw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 01:52:56 -0500
Message-ID: <4402A1C4.6070208@pobox.com>
Date: Mon, 27 Feb 2006 01:52:52 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.16-rc5
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>	<4402934B.7040506@pobox.com> <20060226222114.e549b568.rdunlap@xenotime.net>
In-Reply-To: <20060226222114.e549b568.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Mon, 27 Feb 2006 00:51:07 -0500 Jeff Garzik wrote:
> 
> 
>>Linus Torvalds wrote:
>>
>>>The tar-ball is being uploaded right now, and everything else should 
>>>already be pushed out. Mirroring might take a while, of course.
>>>
>>>There's not much to say about this: people have been pretty good, and it's 
>>>just a random collection of fixes in various random areas. The shortlog is 
>>>actually pretty short, and it really describes the updates better than 
>>>anything else.
>>>
>>>Have I missed anything? Holler. And please keep reminding about any 
>>>regressions since 2.6.15.
>>
>>Yep, you missed the data corruption fix (libata) and oops fix (netdev) 
>>that I sent at 5pm EST today...
>>
>>And we may have to turn off FUA (barriers) before 2.6.16 goes out.
> 
> 
> Jeff, were you planning to make atapi_enabled=1 be the default
> for 2.6.16 ?

It's far too late for that now.

	Jeff



