Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWCFGNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWCFGNs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 01:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWCFGNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 01:13:48 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:23196 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1751356AbWCFGNr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 01:13:47 -0500
Message-ID: <440BD31C.9090801@dgreaves.com>
Date: Mon, 06 Mar 2006 06:13:48 +0000
From: David Greaves <david@dgreaves.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Mark Lord <liml@rtr.ca>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, Mark Lord <lkml@rtr.ca>,
       Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>
Subject: Re: LibPATA code issues / 2.6.15.4
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com> <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com> <44046CE6.60803@rtr.ca> <44046D86.7050809@pobox.com> <4405DCAF.6030500@dgreaves.com> <4405DDEA.7020309@rtr.ca> <4405E42B.9040804@dgreaves.com> <4405E83D.9000906@rtr.ca> <4405EC94.2030202@dgreaves.com> <4405FAAE.3080705@dgreaves.com> <Pine.LNX.4.64.0603031437370.9331@p34> <4408C729.50401@dgreaves.com> <4409A369.1040607@rtr.ca>
In-Reply-To: <4409A369.1040607@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> David Greaves wrote:
>> Just FYI - I'm away (in Canada) for 2 weeks so can't do any additional
>> testing until I return.
>
> Am I correct, in that your last test on rc5-git4 was a failure?
It was *much* better than rc4 but it did have an error.
I *think* the problem I'm seeing is likely to be similar to the one I 
orginally reported (on 2.6.15 IIRC)
Same sporadic warning/error which didn't usually trigger the 
raid-boot-the-disk behaviour that the FUA code seemed to.
> But without the "opcode" display in the error messages,
> so we have no idea exactly what caused the errors (again!)?
Yes. I thought the/a opcode-verbose patch was in  there but I  guess not.
I don't have remote console access to the machine so wouldn't be able to 
carry out reliable kernel tests - sorry.
Of course I'll do this as soon as I return.
>
> [Whatcha doin up here?]
[:) 2weeks skiing in Whistler (this time - 10 days canadian canoeing in 
Algonquin last time!)
Canada's great !!]

David

