Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265414AbSLHN3m>; Sun, 8 Dec 2002 08:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265754AbSLHN3m>; Sun, 8 Dec 2002 08:29:42 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:29111 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265414AbSLHN3m>; Sun, 8 Dec 2002 08:29:42 -0500
Subject: Re: [BUG] 2.4.20-BK
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, hps@intermeta.de
In-Reply-To: <200212081337.56002.m.c.p@wolk-project.de>
References: <200212071434.11514.m.c.p@wolk-project.de>
	<200212072036.08500.m.c.p@wolk-project.de> <asv3d8$nr$1@forge.intermeta.de>
	 <200212081337.56002.m.c.p@wolk-project.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Dec 2002 14:13:24 +0000
Message-Id: <1039356804.6942.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-08 at 12:37, Marc-Christian Petersen wrote:
> On Sunday 08 December 2002 10:29, Henning P. Schmiedehausen wrote:
> 
> Hi Henning,
> 
> > >    ide0: BM-DMA at 0x9400-0x9407, BIOS settings: hda:pio, hdb:pio
> > >    ide1: BM-DMA at 0x9408-0x940f, BIOS settings: hdc:pio, hdd:pio
> > >    ide2: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
> > >    ide3: BM-DMA at 0xffa8-0xffaf, BIOS settings: hda:pio, hdb:DMA
> >
> > Shouldn't these bei hde - hdh ? I'd be scared by my machine reporting
> > hda thrice. :-)
> That's why I've writte this also ;) It's an exact output of what I got.

Send me an lspci -vxx

