Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313773AbSEMOen>; Mon, 13 May 2002 10:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSEMOem>; Mon, 13 May 2002 10:34:42 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:6280 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S313773AbSEMOel>; Mon, 13 May 2002 10:34:41 -0400
Date: Mon, 13 May 2002 16:34:46 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Diego Calleja <DiegoCG@teleline.es>, Andi Kleen <ak@muc.de>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_ISA
In-Reply-To: <E177Gcl-0005SV-00@the-village.bc.nu>
Message-ID: <Pine.GSO.3.96.1020513163036.26083I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2002, Alan Cox wrote:

> >  The PS/2 mouse and the keyboard (or the 8042, actually) are motherboard
> > devices using the 0x00-0xff range of I/O ports -- ISA is above that.
> 
> Not neccessarily. The mobility chipset for example has a PS/2 mouse
> and keyboard port on a PCI card

 Nice to know.  They can't use motherboard ports, though.

 So the choice is between a motherboard and a PCI device.  Neither is ISA. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

