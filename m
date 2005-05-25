Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262258AbVEYD0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbVEYD0v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 23:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbVEYD0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 23:26:51 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:18103 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S262258AbVEYD02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 23:26:28 -0400
Date: Tue, 24 May 2005 23:26:16 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: RT patch acceptance
In-reply-to: <20050524192029.2ef75b89.akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Message-id: <200505242326.16929.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <4292DFC3.3060108@yahoo.com.au> <4293DCB1.8030904@mvista.com>
 <20050524192029.2ef75b89.akpm@osdl.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 May 2005 22:20, Andrew Morton wrote:
>Sven Dietrich <sdietrich@mvista.com> wrote:
>> I think people would find their system responsiveness / tunability
>>  goes up tremendously, if you drop just a few unimportant IRQs
>> into threads.
>
>People cannot detect the difference between 1000usec and 50usec
> latencies, so they aren't going to notice any changes in
> responsiveness at all.

Excuse me? 1 second (1000 usecs, 200 times your 50 usec example) is 
VERY noticeable when you are listening to music, or worse yet, trying 
to edit it.  For much of that, submillisecond accuracy makes or 
breaks the application.

Lets get out of the server only camp here folks, linux is used for a 
hell of a lot more than a home for apache.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
