Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbTCBVld>; Sun, 2 Mar 2003 16:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbTCBVlc>; Sun, 2 Mar 2003 16:41:32 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:39654 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261375AbTCBVlb>;
	Sun, 2 Mar 2003 16:41:31 -0500
Date: Sun, 2 Mar 2003 22:49:42 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arador <diegocg@teleline.es>, "Adam J. Richter" <adam@yggdrasil.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pavel@janik.cz, pavel@ucw.cz
Subject: Re: BitBucket: GPL-ed *notrademarkhere* clone
In-Reply-To: <3E6265AB.9090304@pobox.com>
Message-ID: <Pine.GSO.4.21.0303022247261.9204-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Mar 2003, Jeff Garzik wrote:
> Andrea Arcangeli wrote:
> > I'm not even convinced it will become a full exporter if Larry finally
> > provides the kernel data via an open protocol stored in an open format
> > as he promised us some week ago, go figure how much I can care what it
> > will become after it has the readonly capability.
> 
> I think this is a fair request.
> 
> IMO a good start would be to get BK to export its metadata for each 
> changeset in XML.  Once that is accomplished, (a) nobody gives a damn 
> about BK file format, and (b) it is easy to set up an automated, public 
> distribution of XML changesets that can be imported into OpenCM, cvs, or 
> whatever.

Read: an XML scheme with a public, open specification?

Ask Microsoft how to `encrypt' documents using an `open' standard like XML...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

