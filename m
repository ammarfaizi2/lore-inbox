Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267550AbRG2HGQ>; Sun, 29 Jul 2001 03:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267552AbRG2HGF>; Sun, 29 Jul 2001 03:06:05 -0400
Received: from [209.226.93.226] ([209.226.93.226]:8187 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S267550AbRG2HF4>; Sun, 29 Jul 2001 03:05:56 -0400
Date: Sun, 29 Jul 2001 03:05:06 -0400
Message-Id: <200107290705.f6T756j02316@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@mandrakesoft.com (Jeff Garzik),
        kiwiunixman@yahoo.co.nz (Matthew Gardiner),
        pauld@egenera.com (Philip R. Auld),
        linux-kernel@vger.kernel.org (kernel)
Subject: Re: binary modules (was Re: ReiserFS / 2.4.6 / Data Corruption)
In-Reply-To: <E15QZSA-00083U-00@the-village.bc.nu>
In-Reply-To: <no.id>
	<E15QZSA-00083U-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Alan Cox writes:
> > The right answer for vendors who want to ship binary modules is to
> > ship an Open Source interface layer which shields the vendor from
> > kernel drift (since users will be able to build the interface layer if
> > they need to, without waiting for the vendor).
> 
> As people have seen from vmware and from the ever growing piles of
> nvidia crashes the truth about binary modules in general even with
> glue is pain and suffering.

Sure. If you load a binary module (shim layer or not), you don't get
community support. So vendors are digging their own shitpile by
shipping binary-only drivers. I just don't see the need to shove them
in the back while they do it.

Besides, if someone can make a lot of money shipping binary drivers,
then they can afford the support costs, so it may well be a viable
revenue model for them (at the very least, programmers need to eat
too).

> Veritas have some good Linux people though, and while I'm sad they
> won't open source the core of veritas they do at least appear to
> have the knowledgebase to do a good job

Yeah, I'd rather see all source open. But that's an ideal world. In
the meantime, many people want $$$. One of the great things about
Linux is that it is open and allows different funding models. The
success of Linux is due to the openness, not some cool technological
feature.

Open Source pushes the "innovation envelope". Eventually, the "core"
(what's now the basic OS) which isn't worth selling grows outwards,
consuming areas where it used to be profitable to sell software. So it
forces companies to innovate or die, leading to a dynamic industry.
That is good for both Society and Industry (as seen by the respective
idealogical poles).

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
