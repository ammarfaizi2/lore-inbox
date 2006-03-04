Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751555AbWCDO0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbWCDO0G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 09:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbWCDO0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 09:26:06 -0500
Received: from rtr.ca ([64.26.128.89]:7328 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751543AbWCDO0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 09:26:03 -0500
Message-ID: <4409A369.1040607@rtr.ca>
Date: Sat, 04 Mar 2006 09:25:45 -0500
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: David Greaves <david@dgreaves.com>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, Mark Lord <lkml@rtr.ca>,
       Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>
Subject: Re: LibPATA code issues / 2.6.15.4
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com> <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com> <44046CE6.60803@rtr.ca> <44046D86.7050809@pobox.com> <4405DCAF.6030500@dgreaves.com> <4405DDEA.7020309@rtr.ca> <4405E42B.9040804@dgreaves.com> <4405E83D.9000906@rtr.ca> <4405EC94.2030202@dgreaves.com> <4405FAAE.3080705@dgreaves.com> <Pine.LNX.4.64.0603031437370.9331@p34> <4408C729.50401@dgreaves.com>
In-Reply-To: <4408C729.50401@dgreaves.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Greaves wrote:
> Just FYI - I'm away (in Canada) for 2 weeks so can't do any additional
> testing until I return.

Am I correct, in that your last test on rc5-git4 was a failure?

But without the "opcode" display in the error messages,
so we have no idea exactly what caused the errors (again!)?

[Whatcha doin up here?]

Cheers

