Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263320AbSKCX1X>; Sun, 3 Nov 2002 18:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263342AbSKCX1X>; Sun, 3 Nov 2002 18:27:23 -0500
Received: from mta01bw.bigpond.com ([139.134.6.78]:35058 "EHLO
	mta01bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S263320AbSKCX1W>; Sun, 3 Nov 2002 18:27:22 -0500
Message-ID: <051b01c28391$47168530$41368490@archaic>
From: "David McIlwraith" <quack@bigpond.net.au>
To: <hanwen@cs.uu.nl>
Cc: <linux-kernel@vger.kernel.org>
References: <3DC59E5B.2040007@yahoo.com><200211032253.gA3Mrw1B008818@smtpzilla1.xs4all.nl><1036365120.1540.11.camel@god.stev.org> <15813.44941.592105.853906@blauw.xs4all.nl>
Subject: Re: [Help!] 2.4.20 IDE-SCSI / CD-writing crash
Date: Mon, 4 Nov 2002 10:32:29 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3663.0
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3663.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You mean hdc not hdd, I hope?

----- Original Message -----
From: "Han-Wen Nienhuys" <hanwen@cs.uu.nl>
To: "James Stevenson" <james-lists@stev.org>
Cc: <linux-kernel@vger.kernel.org>
Sent: Monday, November 04, 2002 10:21 AM
Subject: Re: [Help!] 2.4.20 IDE-SCSI / CD-writing crash


> james-lists@stev.org writes:
> > yeah this happens to me under certin combinations of hardware
> > eg dont put a cd write on the same channel as a disk or
> > you seem to run into problems.
>
> The writer is on 2nd IDE channel (hdd), the HD is on  the 1st (hda).
>
> > you saw 2.4.20 ? i dont think that kernel is out yet.
>
> 20-rc1
>
> FWIW, I also tried disabling DMA on the cdrom drive; no-go:   at the
> 3rd burn, the ATAPI resets were all over the place.
>
> --
>
> Han-Wen Nienhuys   |   hanwen@cs.uu.nl   |   http://www.cs.uu.nl/~hanwen
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

