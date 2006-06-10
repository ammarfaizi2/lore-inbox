Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030322AbWFJHH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322AbWFJHH4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 03:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbWFJHHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 03:07:55 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48133 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1030322AbWFJHHz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 03:07:55 -0400
Date: Sat, 10 Jun 2006 06:58:50 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       linville@tuxdriver.com, Denis Vlasenko <vda@ilport.com.ua>,
       acx100-devel@lists.sourceforge.net, acx100-users@lists.sourceforge.net
Subject: Re: wireless (was Re: 2.6.18 -mm merge plans)
Message-ID: <20060610065850.GA4346@ucw.cz>
References: <20060604135011.decdc7c9.akpm@osdl.org> <20060605010636.GB17361@havoc.gtf.org> <20060604181515.8faa8fcf.akpm@osdl.org> <20060605083321.GA15690@rhlx01.fht-esslingen.de> <1149497109.3111.28.camel@laptopd505.fenrus.org> <1149503215.30554.6.camel@localhost.localdomain> <1149503730.3111.46.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149503730.3111.46.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >  It's just that a cleanroom approach is a sure way to prove
> > > you didn't copy. That's all.
> > 
> > Which is an extremely important detail especially if you have been
> > reverse engineering another driver for the same or similar OS where it
> > is likely that people will retain knowledge and copy rather than
> > re-implement th?ngs.
> 
> oh don't get me wrong, it's important to not copy from the original.
> (even if that original did copy from linux ;)

Well, if original did copy from linux, it surely is GPLed and case
closed, no? Being sued from vendor not respecting the GPL would
probably only do harm to them.

Like US courts are crazy, but hopefully not _that_ crazy.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
