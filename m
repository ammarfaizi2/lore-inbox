Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLGRWZ>; Thu, 7 Dec 2000 12:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129597AbQLGRWP>; Thu, 7 Dec 2000 12:22:15 -0500
Received: from Morgoth.esiway.net ([193.194.16.157]:46858 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S129257AbQLGRWJ>; Thu, 7 Dec 2000 12:22:09 -0500
Date: Thu, 7 Dec 2000 17:50:40 +0100 (CET)
From: Marco Colombo <marco@esi.it>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Marco Colombo <marco@esi.it>, James Bourne <jbourne@MtRoyal.AB.CA>,
        "Mike A. Harris" <mharris@opensourceadvocate.org>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: D-LINK DFE-530-TX
In-Reply-To: <E14444b-0002eT-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0012071742010.17276-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
> 

Ehm, does it drive the DFE-530TX, which, I believe, it's a via-rhine?
I had problems with the 530. I've been told that the 538 (rtl8139) works
under the same load (NFS server on a small LAN, and a 5-ports D-Link Switch),
even with the old driver.

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
