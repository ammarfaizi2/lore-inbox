Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbQLGRAF>; Thu, 7 Dec 2000 12:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129708AbQLGQ75>; Thu, 7 Dec 2000 11:59:57 -0500
Received: from Morgoth.esiway.net ([193.194.16.157]:27146 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S129632AbQLGQ73>; Thu, 7 Dec 2000 11:59:29 -0500
Date: Thu, 7 Dec 2000 17:28:59 +0100 (CET)
From: Marco Colombo <marco@esi.it>
To: James Bourne <jbourne@MtRoyal.AB.CA>
cc: "Mike A. Harris" <mharris@opensourceadvocate.org>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: D-LINK DFE-530-TX
In-Reply-To: <Pine.LNX.4.30.0012070705050.13857-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0012071722040.17276-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, James Bourne wrote:

> On Wed, 6 Dec 2000, Mike A. Harris wrote:
> 
> > Which ethernet module works with this card?  2.2.17 kernel
> 
> Should be the rtl8139 driver.

AFAIK, it uses the via-rhine driver. The DFE-538TX is rtl8139 based.
Mike, if you have problems, search list archives: a few people (including
me) reported problems under load. I've never solved them.

> 
> Regards,
> Jim
> 
> > ----------------------------------------------------------------------
> >       Mike A. Harris  -  Linux advocate  -  Open source advocate
> >           This message is copyright 2000, all rights reserved.
> >   Views expressed are my own, not necessarily shared by my employer.
> > ----------------------------------------------------------------------
> 
> 

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
