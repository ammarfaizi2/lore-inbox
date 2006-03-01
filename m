Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751848AbWCATiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbWCATiS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 14:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751820AbWCATiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 14:38:18 -0500
Received: from lucidpixels.com ([66.45.37.187]:1766 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1750790AbWCATiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 14:38:17 -0500
Date: Wed, 1 Mar 2006 14:38:07 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Mark Lord <lkml@rtr.ca>
cc: David Greaves <david@dgreaves.com>, Jeff Garzik <jgarzik@pobox.com>,
       Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>
Subject: Re: LibPATA code issues / 2.6.15.4
In-Reply-To: <4405F78D.7000005@rtr.ca>
Message-ID: <Pine.LNX.4.64.0603011436300.2740@p34>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com>
 <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca>
 <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca>
 <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca>
 <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com>
 <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com>
 <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com> <44046CE6.60803@rtr.ca>
 <44046D86.7050809@pobox.com> <4405DCAF.6030500@dgreaves.com> <4405DDEA.7020309@rtr.ca>
 <4405E42B.9040804@dgreaves.com> <4405E83D.9000906@rtr.ca>
 <Pine.LNX.4.64.0603011405200.3177@p34> <4405F78D.7000005@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Mar 2006, Mark Lord wrote:

> Justin Piszcz wrote:
>> 
>> Did you mean you wanted us to test it like we normally do, ie, copy 
>> files/md5sum them on the disk and see if we can make it occur again, or?
>
> Yes.  The S.M.A.R.T. stuff doesn't matter nearly as much as normal I/O.
>
> And Justin, can you get those S.M.A.R.T. errors to pop up on 2.6.15 as well?
>

Have not tested, can test later if necessary, running some I/O tests to 
the disk which is probably going to take quite a while to see if I can get 
it to error again with 2.6.16-rc5-git4.

Justin.
