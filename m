Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277406AbRJJUZA>; Wed, 10 Oct 2001 16:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277401AbRJJUYs>; Wed, 10 Oct 2001 16:24:48 -0400
Received: from [160.131.145.131] ([160.131.145.131]:10500 "EHLO W20303512")
	by vger.kernel.org with ESMTP id <S277406AbRJJUYh>;
	Wed, 10 Oct 2001 16:24:37 -0400
Message-ID: <04d501c151c9$9a38e1e0$839183a0@W20303512>
From: "Wilson" <defiler@null.net>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0110101239540.1192-100000@twin.uoregon.edu>
Subject: Re: ATA/100 Promise Board
Date: Wed, 10 Oct 2001 16:24:45 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Joel Jaeggli" <joelja@darkwing.uoregon.edu>
To: "Wilson" <defiler@null.net>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, October 10, 2001 3:49 PM
Subject: Re: ATA/100 Promise Board

> > Quoting from pdc202xx.c:
> >
> >  *  The latest chipset code will support the following ::
> >  *  Three Ultra33 controllers and 12 drives.
> >  *  8 are UDMA supported and 4 are limited to DMA mode 2 multi-word.
> >  *  The 8/4 ratio is a BIOS code limit by promise.
> >  *
> >  *  UNLESS you enable "CONFIG_PDC202XX_BURST"
> >
> > Does this match your experiences with that many controllers in the same
box?
> > Thanks for the reply, by the way.
>
> I don't have any of the ultra33 (20246) controllers... but I do have
> CONFIG_PDC202XX_BURST set (ie. the "enabled special dma feature").
> everything is more or less normal except that I think hdk in the box is
> slowly dying at this point... this box has 8 drives on four controllers
> rather than 12 on 3
>
> hda: WDC AC22000L, ATA DISK drive
> hdc: IBM-DTLA-307015, ATA DISK drive
> hde: Maxtor 98196H8, ATA DISK drive
> hdg: IBM-DTLA-307075, ATA DISK drive
> hdi: WDC AC418000D, ATA DISK drive
> hdk: WDC AC418000D, ATA DISK drive
> hdm: WDC WD273BA, ATA DISK drive
> hdo: WDC WD273BA, ATA DISK drive
>

Awesome. Thanks for the info. I'll feel relatively safe recommending this
kind of thing to others in the future, then.

--Wilson.


