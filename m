Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285842AbRLYUyu>; Tue, 25 Dec 2001 15:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285879AbRLYUyk>; Tue, 25 Dec 2001 15:54:40 -0500
Received: from hera.cwi.nl ([192.16.191.8]:17575 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S285842AbRLYUy1>;
	Tue, 25 Dec 2001 15:54:27 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 25 Dec 2001 20:54:15 GMT
Message-Id: <UTC200112252054.UAA97748.aeb@cwi.nl>
To: Andries.Brouwer@cwi.nl, pavel@suse.cz
Subject: Re: Configure.help editorial policy
Cc: bcrl@redhat.com, cw@f00f.org, esr@thyrsus.com,
        garfield@irving.iisd.sra.com, linux-kernel@vger.kernel.org,
        riel@conectiva.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    > > In many cases binary and decimal units are mixed,
    > > leading to something which is impossible to "get right".
    > > Disk space would be one example of this.
    > 
    > No. All disk manufacturers only use decimal units.

    Really? Even ATA flashcard manufacturers? So now I have to know if
    CF-card has spinning parts to decide size?

What makes you think so?

Looking at a flash card here (sold as 8 MB), I see

SCSI device sdb: 15872 512-byte hdwr sectors (8 MB)

Now if the manufacturer claimed 8 MiB I could sue him,
but since he only claims 8 MB, this one is large enough
(it has 31 . 2^18 = 8126464 bytes).
It is 8.1 MB and 7.75 MiB.

Andries


Always remember:
(i) k=1000, M=1000k, G=1000M
(ii) specifications are rounded down, so that customers cannot complain
(iii) if something exists only in power-of-two sizes, that helps
guessing the actual size; however, this is not true for disks,
and as this example shows, it is not true for CF cards either.
