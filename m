Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272588AbRILUN0>; Wed, 12 Sep 2001 16:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272592AbRILUNQ>; Wed, 12 Sep 2001 16:13:16 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:14611 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S272588AbRILUM7>; Wed, 12 Sep 2001 16:12:59 -0400
Date: Wed, 12 Sep 2001 22:13:17 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Jussi Laako <jlaako@pp.htv.fi>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: VIA chipset
In-Reply-To: <3B9FC05F.D35040C8@pp.htv.fi>
Message-ID: <Pine.LNX.4.33.0109122209470.8745-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2001, Jussi Laako wrote:

> Marco Colombo wrote:
> >
> > Sorry to bother you again with this issue, Alan... by 'AMD chipsets'
> > you mean BOTH north and south bridges (eg. 761 + 766) or does it include
> > also AMD NB + VIA SB combo?
> > AMD 761 + VIA 686B based MBs are quite common this days: are they "safe"
> > (do you have failure reports)?
>
> At least my ASUS A7M266 works very well. It has AMD 761 nb and VIA 686B sb
> and the 686B is used only for IDE and IO interfaces. PCI bus comes from the
> 761, AFAIK.
>
>  - Jussi Laako
>

Thanks for your answer! Can you please confirm me that both the ATA/100
controller (at ATA/66 or ATA/100 speed) and Athlon optimized kernels work?

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

