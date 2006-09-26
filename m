Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbWIZTp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbWIZTp5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 15:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbWIZTp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 15:45:57 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:16143 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932496AbWIZTp4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 15:45:56 -0400
Date: Tue, 26 Sep 2006 19:45:42 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Vladimir <vovan888@gmail.com>
Cc: lamikr@cc.jyu.fi, tony@atomide.com,
       OMAP-Linux <linux-omap-open-source@linux.omap.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] Add gsm phone support for the mixer in tsc2101 alsa driver.
Message-ID: <20060926194541.GA4596@ucw.cz>
References: <44E51565.6020505@cc.jyu.fi> <20060905151808.GC18073@atomide.com> <44FF2A6D.3000500@cc.jyu.fi> <ce55079f0609250442x5638a93fuac95c65a54a0927@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce55079f0609250442x5638a93fuac95c65a54a0927@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >1) As we do not yet have any kind of multiplexing 
> >support to gsm module
> >(currently directly accesing dev/ttyS1 for at commands)
> >our phone app is not able to run simultaneously with 
> >the ppp. I am not
> >sure should I resolve this in the kernel space or user 
> >space.
> >
> 
> I work on getting linux running on Siemens SX1 mobile 
> phone.

Do you have web pages with current state somewhere? SX1 should be
*cheap* toy for experiments...
							Pavel
-- 
Thanks for all the (sleeping) penguins.
