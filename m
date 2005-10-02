Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbVJBXcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbVJBXcD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 19:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVJBXcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 19:32:03 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:45819 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751098AbVJBXcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 19:32:02 -0400
Date: Sun, 02 Oct 2005 19:32:00 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: what's next for the linux kernel?
In-reply-to: <4340627F.6010303@shaw.ca>
To: linux-kernel@vger.kernel.org
Message-id: <200510021932.00969.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4340627F.6010303@shaw.ca>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 October 2005 18:43, Robert Hancock wrote:
>Luke Kenneth Casson Leighton wrote:
>> and, what is the linux kernel?
>>
>> it's a daft, monolithic design that is suitable and faster on
>> single-processor systems, and that design is going to look _really_
>> outdated, really soon.
>
>Well, it sounds like it works pretty well on such things as 512 CPU
>Altix systems, so it sounds like the suggestion that Linux is designed
>solely for single-processor systems and isn't suitable for multicore,
>hyperthreaded CPUs doesn't hold much water..

Ahh, yes and no, Robert.  The un-answered question, for that
512 processor Altix system, would be "but does it run things 512
times faster?"  Methinks not, by a very wide margin.  Yes, do a lot
of unrelated things fast maybe, but render a 30 megabyte page with
ghostscript in 10 milliseconds?  Never happen IMO.

And Christoph in the next msg, calls him 1/2 drunk.  He doesn't come
across to me as being more than 1 beer drunk.  And he does make some
interesting points, so if they aren't valid, lets use proveable logic
to shoot them down, not name calling and pointless rhetoric.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.


