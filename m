Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289735AbSAWIwH>; Wed, 23 Jan 2002 03:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289737AbSAWIv5>; Wed, 23 Jan 2002 03:51:57 -0500
Received: from skiathos.physics.auth.gr ([155.207.123.3]:20676 "EHLO
	skiathos.physics.auth.gr") by vger.kernel.org with ESMTP
	id <S289735AbSAWIvo>; Wed, 23 Jan 2002 03:51:44 -0500
Date: Wed, 23 Jan 2002 10:51:38 +0200 (EET)
From: Liakakis Kostas <kostas@skiathos.physics.auth.gr>
To: Nils Rennebarth <nils@ipe.uni-stuttgart.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17: Hang after IDE detection
In-Reply-To: <20020122173815.GH900@ipe.uni-stuttgart.de>
Message-ID: <Pine.GSO.4.21.0201231050390.11266-100000@skiathos.physics.auth.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2002, Nils Rennebarth wrote:

> On Tue, Jan 22, 2002 at 05:18:27PM +0200, Liakakis Kostas wrote:
> > SIS5513: chipset revision 208
> > SIS5513: not 100% native mode: will probe irqs later
> > SIS5597
> >     ide0: BM-DMA at 0x4000-0x4007, BIOS settings hda:pio, hdb:pio
> >     ide1: BM-DMA at 0x4008-0x400f, BIOS settings hdc:pio, hdb:pio
> for me the hang happens here. Other symptoms are about the same.

I had this happen too. The readout was for 2.4.17 behaviour with the given
config. I remember another kernel crash at this poit too.

-K.


