Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316789AbSGRATy>; Wed, 17 Jul 2002 20:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317007AbSGRATy>; Wed, 17 Jul 2002 20:19:54 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:50816 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S316789AbSGRATx>; Wed, 17 Jul 2002 20:19:53 -0400
Date: Thu, 18 Jul 2002 02:22:34 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>,
       Klaus Dittrich <kladit@t-online.de>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19rc2 and Promise RAID controller
In-Reply-To: <Pine.LNX.4.44.0207172017280.25929-100000@freak.distro.conectiva>
Message-ID: <Pine.SOL.4.30.0207180219341.12077-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 17 Jul 2002, Marcelo Tosatti wrote:

> Klaus,
>
> Could you please set CONFIG_PDC202XX_FORCE to on and see what happens?

Rather set it off.

> On 17 Jul 2002, Alan Cox wrote:
>
> > On Wed, 2002-07-17 at 17:54, Andre Hedrick wrote:
> > >
> > > This is just proves that accepting the patch code from Promise will begin
> > > to remove basic support for hardware.  I warned everyone of this and
> > > people do not listen.  So I suggest that you find another vendors product
> > > to use as the PDC20270 shall not be supported anymore.
> >
> > Andre, this is not the case. We all agreed to sort out the raid detect.
> > I sent Marcelo a diff and some instructions. He applied the diff but I
> > guess my instructions were too confusing. It'll get fixed for -rc3
> >
> > If you want a conspiracy to play with look elsewhere (there are no
> > shortage of real ones 8))
> >
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

