Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130842AbQLJRFW>; Sun, 10 Dec 2000 12:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131078AbQLJRFM>; Sun, 10 Dec 2000 12:05:12 -0500
Received: from tonib-gw-old.customer.0rbitel.net ([195.24.39.218]:15876 "HELO
	gateway.izba.bg") by vger.kernel.org with SMTP id <S130842AbQLJREh>;
	Sun, 10 Dec 2000 12:04:37 -0500
Date: Sun, 10 Dec 2000 18:34:09 +0200 (EET)
From: Vasil Kolev <lnxkrnl@mail.ludost.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18 almost...
In-Reply-To: <E144syy-0005sE-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10012101831380.2586-100000@doom.bastun.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Dec 2000, Alan Cox wrote:

> The patch I intend to be 2.2.18 is out as 2.2.18pre26 in the usual place.
> I'll move it over tomorrow if nobody reports any horrors, missing files etc
> 
Will
ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.18pre25/VM-global-2.2.18pre25-7.bz2
be included in the final 2.2.18 ? I found that it helped us - we had the
problem with 'trying to free pages' even with 2.2.18pre25 , but that
patch helped, now the machine is like ' rock stable' :)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
