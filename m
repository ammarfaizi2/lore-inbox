Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280633AbRKNPMk>; Wed, 14 Nov 2001 10:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280632AbRKNPMb>; Wed, 14 Nov 2001 10:12:31 -0500
Received: from [140.249.38.181] ([140.249.38.181]:29960 "EHLO
	neptune.cuseeme.com") by vger.kernel.org with ESMTP
	id <S280631AbRKNPMO>; Wed, 14 Nov 2001 10:12:14 -0500
Message-ID: <6A5AF4EA59EB214BB0267741CE2C86EF0E0791@neptune.cuseeme.com>
From: Brian Raymond <braymond@fvc.com>
To: "'Alastair Stevens'" <alastair.stevens@mrc-bsu.cam.ac.uk>,
        Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Athlon SMP blues - kernels 2.4.[9 13 15-pre4]
Date: Wed, 14 Nov 2001 10:07:25 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Right from AMD's datasheet on the Athon XP..

Multiprocessing support: point-to-point topology, with number of processors
in SMP systems determined by chipset implementation 

Looks like it supports SMP.

- Brian


-----Original Message-----
From: Alastair Stevens [mailto:alastair.stevens@mrc-bsu.cam.ac.uk]
Sent: Wednesday, November 14, 2001 10:04 AM
To: Arjan van de Ven
Cc: linux-kernel@vger.kernel.org
Subject: Re: Athlon SMP blues - kernels 2.4.[9 13 15-pre4]


> > Hi folks - I'm having real problems getting our new dual CPU server
> > going. It's a 2x Athlon XP 1800+ on a Tyan mobo, AMD 760MP chipset, with
>
> Ehm you know that XP cpu's don't support SMP configuration ?

Erm, no....

If this really is the case, then obviously my supplier doesn't know
either, as he's quite definitively stuck two of them on my mobo!
Linux happily detects two XP 1800+ CPUs on boot, but then both SMP
and UP kernels fail in this strange way. If they didn't boot at all, it
would almost be more helpful ;-)

Cheers
Alastair

_____________________________________________
Alastair Stevens
MRC Biostatistics Unit
Cambridge UK
---------------------------------------------
phone - 01223 330383
email - alastair.stevens@mrc-bsu.cam.ac.uk
web - www.mrc-bsu.cam.ac.uk

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
