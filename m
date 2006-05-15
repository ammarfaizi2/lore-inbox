Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbWEOTYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWEOTYO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWEOTYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:24:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:23748 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750976AbWEOTYM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:24:12 -0400
X-Authenticated: #420190
Message-ID: <4468D53F.9090507@gmx.net>
Date: Mon, 15 May 2006 21:23:43 +0200
From: Marko Macek <Marko.Macek@gmx.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: ak@suse.de
CC: linux-kernel@vger.kernel.org
Subject: Re: ASUS A8V Deluxe, x86_64
References: <8E8F647D7835334B985D069AE964A4F7028FDBFE@ECQCMTLMAIL1.quebec.int.ec.gc.ca> <p738xp35co4.fsf@bragg.suse.de>
In-Reply-To: <p738xp35co4.fsf@bragg.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA> writes:
> 
>>> I also have A8V Deluxe.
>>>
>>> No real problems with single core A64 3000.
>>>
>>> But now with and X2 dual core CPU, I needed to disable 
>>> irqbalance to get any stability.
>> Hein? Via xconfig?
> 
> I cant't see the parent message (did you mess up the cc?) of the
> person with irqbalanced troubles, but most likely he has a SIS chipset, right? 

No, VIA A8V Deluxe.

See for example:

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=182618

Regards,
Mark
