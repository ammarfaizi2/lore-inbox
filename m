Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbTEQQrs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 12:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbTEQQrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 12:47:48 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:9180 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S261669AbTEQQrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 12:47:47 -0400
Date: Sat, 17 May 2003 18:58:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Jeff Garzik <jgarzik@pobox.com>,
       David Gibson <hermes@gibson.dropbear.id.au>,
       Benjamin Reed <breed@almaden.ibm.com>,
       Javier Achirica <achirica@ttd.net>, Jouni Malinen <jkmaline@cc.hut.fi>
Subject: Re: 2.6 must-fix list, v3
Message-ID: <20030517165820.GB283@elf.ucw.cz>
References: <20030514211222.GA10453@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514211222.GA10453@bougret.hpl.hp.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Quite a lot of changes here.  Mostly additions, but some things have been
> > crossed off.
> > 
> > Also at ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/must-fix
> 
> 	I don't like making todo list for other people, because it's
> up to them to decide, but here is my wishlist for 2.6.X in term of
> Wireless stuff.
> 	I hope those concerned will react and send you their real todo
> list.
> 
> 	o get latest orinoco changes from David. Linus seems timely in
> picking David's changes, so I'm not worried about this one.
> 
> 	o get the latest airo.c fixes from CVS. This will hopefully
> fix problems people have reported on the LKML.
> 
> 	o get HostAP driver in the kernel. No consolidation of the
> 802.11 management across driver can happen until this one is in (which
> is probably 2.7.X material). I think Jouni is mostly ready but didn't
> find time for it.
> 
> 	o get more wireless drivers into the kernel. The most
> "integrable" drivers at this point seem the NWN driver, Pavel's
> Spectrum driver and the Atmel driver.

Is that Pavel Roskin or is there another Pavel around here? 

							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
