Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268824AbRG0KsZ>; Fri, 27 Jul 2001 06:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268827AbRG0KsQ>; Fri, 27 Jul 2001 06:48:16 -0400
Received: from [194.102.102.3] ([194.102.102.3]:60678 "EHLO ns1.Aniela.EU.ORG")
	by vger.kernel.org with ESMTP id <S268824AbRG0KsF>;
	Fri, 27 Jul 2001 06:48:05 -0400
Date: Fri, 27 Jul 2001 13:49:32 +0300 (EEST)
From: <lk@Aniela.EU.ORG>
To: Miloslaw Smyk <thorgal@amiga.com.pl>
Cc: "Mike A. Harris" <mharris@opensourceadvocate.org>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Hard disk problem:
In-Reply-To: <3B613041.C1330757@amiga.com.pl>
Message-ID: <Pine.LNX.4.33.0107271349080.21369-100000@ns1.Aniela.EU.ORG>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


do you know if the ones made in thailand have the same problem ?



On Fri, 27 Jul 2001, Miloslaw Smyk wrote:

> "Mike A. Harris" wrote:
> >
> > Is this a hardware or software problem, or could it be either?
> >
> > Jul 26 23:51:59 asdf kernel: hda: dma_intr: status=0x51
> > { DriveReady SeekComplete Error }
> > Jul 26 23:51:59 asdf kernel: hda: dma_intr: error=0x40
> > { UncorrectableError }, LBAsect=8545004, sector=62608
> > Jul 26 23:51:59 asdf kernel: end_request: I/O error, dev 03:05
> > (hda), sector 62608
> >
> > Just got it opening up a mail folder.  Drive made a bit of noise
> > and then PINE had to be killed.
> >
> > 2 root@asdf:~# hdparm -i /dev/hda
> >
> > /dev/hda:
> >
> >  Model=IBM-DTLA-307030, FwRev=TX4OA50C, SerialNo=YKDYKGF1437
>
> Ah, one of these excellent Hungarian DTLA drives? :) AFAIK, the entire batch
> was broken, although there are people who insist that there was no single
> working hard drive leaving that factory! I personally have seen 7 out of 7
> failing...
>
> Take it back to where you bought it and demand a replacement for something
> NOT bearing "MADE IN HUNGARY" sign.
>
> cheers,
> Milek
> --
> mailto:thorgal@amiga.com.pl   |  "Man in the Moon and other weird things" -
> http://wfmh.org.pl/~thorgal/  |  see it at http://wfmh.org.pl/~thorgal/Moon/
>          Fight for the good cause: http://www.laubzega.com/dvd/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

