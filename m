Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129831AbQLGRTP>; Thu, 7 Dec 2000 12:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131459AbQLGRTF>; Thu, 7 Dec 2000 12:19:05 -0500
Received: from mail.mtroyal.ab.ca ([142.109.10.22]:24843 "EHLO
	mailgate.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S129831AbQLGRS6>; Thu, 7 Dec 2000 12:18:58 -0500
Date: Thu, 07 Dec 2000 09:47:22 -0700 (MST)
From: James Bourne <jbourne@MtRoyal.AB.CA>
Subject: Re: D-LINK DFE-530-TX
In-Reply-To: <E14444b-0002eT-00@the-village.bc.nu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: marco@esi.it (Marco Colombo), jbourne@MtRoyal.AB.CA (James Bourne),
        mharris@opensourceadvocate.org (Mike A. Harris),
        linux-kernel@vger.kernel.org (Linux Kernel mailing list)
Message-id: <Pine.LNX.4.30.0012070945260.13953-100000@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Alan Cox wrote:

> > > Should be the rtl8139 driver.
> >
> > AFAIK, it uses the via-rhine driver. The DFE-538TX is rtl8139 based.
> > Mike, if you have problems, search list archives: a few people (including
> > me) reported problems under load. I've never solved them.
>
> 2.2.18pre24 has the 8139too driver that Jeff Garzik built from a mix of his
> own work and Don Becker's rather unreliable rtl8129.c driver. It seems to be
> way better (but not perfect)

Yes, still running 2.2.17 though.

The DFE-530TX is the viacom chipset, but the DFE530TX+ (Which I guess
replaces the 538 as that is no longer listed on the Dlink site) is an
rtl8139 chip.

Jim


>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-- 
James Bourne, Web Systems Administrator
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
