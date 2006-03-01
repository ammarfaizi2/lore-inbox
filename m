Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWCASsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWCASsk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 13:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbWCASsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 13:48:40 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:60880 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1750862AbWCASsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 13:48:39 -0500
Message-ID: <4405EC94.2030202@dgreaves.com>
Date: Wed, 01 Mar 2006 18:48:52 +0000
From: David Greaves <david@dgreaves.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>,
       Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>
Subject: Re: LibPATA code issues / 2.6.15.4
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com> <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com> <44046CE6.60803@rtr.ca> <44046D86.7050809@pobox.com> <4405DCAF.6030500@dgreaves.com> <4405DDEA.7020309@rtr.ca> <4405E42B.9040804@dgreaves.com> <4405E83D.9000906@rtr.ca>
In-Reply-To: <4405E83D.9000906@rtr.ca>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:

> By the way, the latest 2.6.16-rc5-git4 is available,
> and has FUA turned off by default now.  So it should
> work with your drives, and *you* are expected to verify
> that for us all now.

Yeah, I know - I've got it on the machine... but it's my wife's machine.
I've asked nicely but she's editing a Hercule Poirot video so I'm not
allowed to reboot it for a while...

I've told her I'm not making pancakes until I've tested it so expect a
report Real Soon Now...

David

