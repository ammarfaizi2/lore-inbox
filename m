Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280820AbRKGP06>; Wed, 7 Nov 2001 10:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280818AbRKGP0t>; Wed, 7 Nov 2001 10:26:49 -0500
Received: from main.sonytel.be ([195.0.45.167]:57004 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S280821AbRKGP0f>;
	Wed, 7 Nov 2001 10:26:35 -0500
Date: Wed, 7 Nov 2001 16:26:27 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: SCSI Tape corruption - update
In-Reply-To: <20011102074532.C708-100000@gerard>
Message-ID: <Pine.GSO.4.21.0111071624270.550-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2001, [ISO-8859-1] Gérard Roudier wrote:
> On Thu, 1 Nov 2001, Geert Uytterhoeven wrote:
> > [ About SCSI tape corruption with sym53c8xx, some months ago ]
> >
> > On Fri, 27 Jul 2001, Gérard Roudier wrote:
> > > On Fri, 27 Jul 2001, Geert Uytterhoeven wrote:
> > > > With some small modifications, I made 1.5a to work fine. No error burst. So the
> > > > problem is introduced between 1.5a and 1.5g.
> > >
> > > Fine! But diffs between 1.5a and 1.5g are still large. :(
> > > Results with 1.5c would have divided the diffs by about 2. :(

1.5c seems to be fine!

Still have to try 1.5d, 1.5g1, 1.5g2 and 1.5g3.
1.5e and 1.5f are nowhere available?

> As driver sym-2 is planned to replace sym53c8xx in the future, it would be
> interesting to give it a try on your hardware. There are some source
> available from ftp.tux.org, but I can provide you with a flat patch
> against the stock kernel version you want. You may let me know.

I just saw the sym-2 driver enter the ac-series. As soon as I have a recent
2.4.x kernel on this box, I can give it a try...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

