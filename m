Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262033AbSJ2RSX>; Tue, 29 Oct 2002 12:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262083AbSJ2RSW>; Tue, 29 Oct 2002 12:18:22 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:6374 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S262033AbSJ2RSV>;
	Tue, 29 Oct 2002 12:18:21 -0500
Date: Tue, 29 Oct 2002 09:24:40 -0800
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Pawel Kot <pkot@bezsensu.pl>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Dag Brattli <dag@brattli.net>, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: Re: [2.4 patch] remove obsolete IrDA list from MAINTAINERS
Message-ID: <20021029172440.GD32449@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <Pine.LNX.4.33.0210201806170.637-100000@urtica.linuxnews.pl> <Pine.NEB.4.44.0210291611510.14144-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.44.0210291611510.14144-100000@mimas.fachschaften.tu-muenchen.de>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2002 at 04:18:09PM +0100, Adrian Bunk wrote:
> On Sun, 20 Oct 2002, Pawel Kot wrote:
> 
> > On Sun, 20 Oct 2002, Adrian Bunk wrote:
> >
> > > Mail to the list that is in MAINTAINERS bounces and the new mailinglist
> > > doesn't accept mail from non-subscribers. Since you can find this new
> > > mailinglist at the IrDA web page it's IMHO the best to simply remove the
> > > mailing list entry from MAINTAINERS:
> >...
> > The new mailing list for Linux-IrDA is: irda-users@lists.sourceforge.net
> 
> I wrote in my mail "and the new mailinglist doesn't accept mail from
> non-subscribers". This makes a mailing list entry IMHO pretty useless
> since I try to Cc a mailing list listed in MAINTAINERS if possible when
> sending a patch / bug report in this area. With a mailing list that
> accepts only postings from subscribers such a mail bounces back.
> 
> The information how to subscribe to this list is available at the web page
> also in this MAINTAINER entry.

	Unfortunately, due to SPAM, this is nowadays pretty much
customary. I deal on a regular basis with dozen of lists related to
Linux-Wireless, and most of them are this way.

> > and the current mainainer is AFAIK Jean Tourrilhes
> > (jt@bougret.hpl.hp.com).
> 
> I have no knowledge about who currently maintains IrDA. I did only notice
> that an obsolete mailing list was listed in MAINTAINERS. If the
> responsible person listed is wrong it should be corrected.

	I'll correct that later on. I sent a patch earlier, but it was
dropped, so I need to resend it. The situation is more complex because
I don't maintain the *full* IrDA stack, and I'll probably add the
driver entries.

> cu
> Adrian

	Jean
