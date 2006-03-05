Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752269AbWCEXjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbWCEXjt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 18:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbWCEXjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 18:39:49 -0500
Received: from mail.dvmed.net ([216.237.124.58]:30683 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751309AbWCEXjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 18:39:48 -0500
Message-ID: <440B76B4.5080502@pobox.com>
Date: Sun, 05 Mar 2006 18:39:32 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: Justin Piszcz <jpiszcz@lucidpixels.com>,
       David Greaves <david@dgreaves.com>, Tejun Heo <htejun@gmail.com>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>
Subject: Re: LibPATA code issues / 2.6.15.4
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com> <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com> <44046CE6.60803@rtr.ca> <44046D86.7050809@pobox.com> <4405DCAF.6030500@dgreaves.com> <4405DDEA.7020309@rtr.ca> <4405E42B.9040804@dgreaves.com> <4405E83D.9000906@rtr.ca> <4405EC94.2030202@dgreaves.com> <4405FAAE.3080705@dgreaves.com> <Pine.LNX.4.64.0603050637110.30164@p34> <Pine.LNX.4.64.0603050740500.3116@p34> <440B6CFE.4010503@rtr.ca>
In-Reply-To: <440B6CFE.4010503@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> SCSI opcode 0x35 is SYNCHRONIZE_CACHE.
> 
> Pity we don't know exactly what that got translated to by libata.

Gave up on reading code?  If not, we know exactly what it was translated 
into.

	Jeff

