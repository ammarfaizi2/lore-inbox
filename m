Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWIZUsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWIZUsc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 16:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWIZUsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 16:48:32 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26014 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964797AbWIZUsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 16:48:31 -0400
Date: Tue, 26 Sep 2006 22:48:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Vovan <vovan888@gmail.com>
Cc: lamikr@cc.jyu.fi, tony@atomide.com,
       OMAP-Linux <linux-omap-open-source@linux.omap.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] Add gsm phone support for the mixer in tsc2101 alsa driver.
Message-ID: <20060926204827.GA4714@elf.ucw.cz>
References: <44E51565.6020505@cc.jyu.fi> <20060905151808.GC18073@atomide.com> <44FF2A6D.3000500@cc.jyu.fi> <ce55079f0609250442x5638a93fuac95c65a54a0927@mail.gmail.com> <20060926194541.GA4596@ucw.cz> <op.tgh52caydbah4f@vovan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.tgh52caydbah4f@vovan>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>I work on getting linux running on Siemens SX1 mobile
> >>phone.
> >
> >Do you have web pages with current state somewhere? SX1 should be
> >*cheap* toy for experiments...

I googled a bit, and its price in czech republic is ~$100..$140.

> Sure:
> http://www.handhelds.org/moin/moin.cgi/SiemensSX1

Thanks! ...so you were able to get most of stuff working, but do not
have qt/gpe working, and probably do not have suspend working so
battery life is really bad, right?

OTOH you can dual boot with symbian... so battery life is not _as_ bad
problem. Do you need windows machine to apply patch allowing you to
run uboot? Is there easy way to tell difference between 32MB and 24MB
sx1's? Getting 24MB part would spoil all the fun, I'm afraid...

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
