Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031210AbWI0XEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031210AbWI0XEc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 19:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031211AbWI0XEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 19:04:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30137 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1031210AbWI0XEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 19:04:30 -0400
Date: Wed, 27 Sep 2006 16:04:11 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Krzysztof Halasa <khc@pm.waw.pl>,
       Nicolas Mailhot <nicolas.mailhot@laposte.net>,
       linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: GPLv3 Position Statement
In-Reply-To: <1159398089.11049.381.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0609271555100.3952@g5.osdl.org>
References: <43447.192.54.193.51.1159350218.squirrel@rousalka.dyndns.org> 
 <Pine.LNX.4.64.0609271031300.3952@g5.osdl.org>  <m33bad9hgy.fsf@defiant.localdomain>
  <Pine.LNX.4.64.0609271336200.3952@g5.osdl.org> <1159398089.11049.381.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Sep 2006, Alan Cox wrote:
> 
> Actually some of the smarter ones wired it to the SMM indications in the
> chipset so that only BIOS controlled SMM management code can do the
> update and that does checksumming or basic very crude crypto type
> checks.
> 
> Fortunately the thought of a slammer equivalent that erases the firmware
> isn't something most vendors want to risk their stock price and business
> on.

Amen to that. 

I'm pretty convinced that some companies sometimes go to unreasonable 
lengths in their fear of liability suits (but in their defense, it's not 
like the US legal environment isn't encouraging it), but I think a lot of 
people end up doing things like that our of very basic prudence.

Not because they are "evil" or even mean anything bad at all, but simply 
because they have their own reasons to believe strongly that people must 
not upgrade their hardware.

Most technology people may _want_ to upgrade their hardware, but when you 
look at all the spyware "upgrades" people get on their windows boxes, you 
can certainly understand why there are reasons for things like strong 
crypto upgrades with secret keys even quite apart from anything like the 
RIAA.

		Linus
