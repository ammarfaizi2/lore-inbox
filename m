Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWDMQrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWDMQrI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 12:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWDMQrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 12:47:08 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:61924 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750814AbWDMQrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 12:47:07 -0400
Date: Thu, 13 Apr 2006 18:47:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-pcmcia@lists.infradead.org, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>, metan@seznam.cz
Subject: Re: 2.6.17-rc1: collie -- oopsen in pccardd?
Message-ID: <20060413164706.GB18635@atrey.karlin.mff.cuni.cz>
References: <20060404122212.GG19139@elf.ucw.cz> <20060404124350.GA16857@flint.arm.linux.org.uk> <20060404000129.GA2590@ucw.cz> <1144923105.7236.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144923105.7236.18.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > I'm getting some oopses when inserting/removing pccard (on collie,
> > > > oopses in pccardd). It does not break boot, so it is not immediate
> > > > problem, but I wonder if it also happens on non-collie machines?
> > > 
> > > No idea what so ever.  Not even any clues as to what might be going wrong
> > > due to the lack of oops dump.  (Not that I even look after PCMCIA anymore.)
> > 
> > Sorry for lack of oops. I was not expecting you to debug it, I
> > expected some voices telling me it is broken for them, too :-).
> 
> With a recent git kernel (907d91d708d9999bec0185d630062576ac4181a7) I
> see the oops below when booting spitz (SL-C3000 - ARM pxa270 based). Was
> this the same oops you saw Pavel?

I think so.
								Pavel

-- 
Thanks, Sharp!
