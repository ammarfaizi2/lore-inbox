Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbQLGR3I>; Thu, 7 Dec 2000 12:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129784AbQLGR26>; Thu, 7 Dec 2000 12:28:58 -0500
Received: from Morgoth.esiway.net ([193.194.16.157]:53514 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S129562AbQLGR2q>; Thu, 7 Dec 2000 12:28:46 -0500
Date: Thu, 7 Dec 2000 17:56:29 +0100 (CET)
From: Marco Colombo <marco@esi.it>
To: James Bourne <jbourne@MtRoyal.AB.CA>
cc: "Mike A. Harris" <mharris@opensourceadvocate.org>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: D-LINK DFE-530-TX
In-Reply-To: <Pine.LNX.4.30.0012070945260.13953-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0012071753590.17276-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, James Bourne wrote:

> On Thu, 7 Dec 2000, Alan Cox wrote:
> 
> > > > Should be the rtl8139 driver.
> > >
> > > AFAIK, it uses the via-rhine driver. The DFE-538TX is rtl8139 based.
> > > Mike, if you have problems, search list archives: a few people (including
> > > me) reported problems under load. I've never solved them.
> >
> > 2.2.18pre24 has the 8139too driver that Jeff Garzik built from a mix of his
> > own work and Don Becker's rather unreliable rtl8129.c driver. It seems to be
> > way better (but not perfect)
> 
> Yes, still running 2.2.17 though.
> 
> The DFE-530TX is the viacom chipset, but the DFE530TX+ (Which I guess
> replaces the 538 as that is no longer listed on the Dlink site) is an
> rtl8139 chip.

You mean that D-Link made a card named DFE530TX VIA based and one named
DFE530TX+ rtl based? Isn't it a bit confusing? B-)

> 
> Jim

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
