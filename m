Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288621AbSADMXO>; Fri, 4 Jan 2002 07:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288620AbSADMXF>; Fri, 4 Jan 2002 07:23:05 -0500
Received: from [129.27.43.9] ([129.27.43.9]:15376 "EHLO xarch.tu-graz.ac.at")
	by vger.kernel.org with ESMTP id <S288618AbSADMWy>;
	Fri, 4 Jan 2002 07:22:54 -0500
Date: Fri, 4 Jan 2002 13:22:52 +0100 (CET)
From: Alex <mail_ker@xarch.tu-graz.ac.at>
To: Dave Jones <davej@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <Pine.LNX.4.33.0201041317470.18539-100000@Appserv.suse.de>
Message-ID: <Pine.LNX.4.10.10201041321330.16901-100000@xarch.tu-graz.ac.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Jan 2002, Dave Jones wrote:

> On Fri, 4 Jan 2002, Alex wrote:
> 
> > Maybe the best thing would be to supply the kernel a "large" _textfile_
> > with all the hardware the user definitely has (at such-and such
> > irq/dma/io); the textfile could be the output resilt from a
> > "userfriendly" hardware-detection tool that lists all categories of
> > hardwares etc. and has - generally - a large hardware database.
> 
> Think about ancient hardware (Yes theres lots of it still in use)
> These beasts had jumpers to set IRQ/DMA etc, and this was not detectable
> from software until PNPISA arrived on the scene.
> 
> You're still going to need user interaction for a lot of these.

That is why I recommended that the textfile is the output of an
interactive hardware-detection tool. Yes, interactive. :-)

> "But Microsoft doesn't" isn't an argument any more either, they dropped
> support for really ancient hardware a long time ago.

Show them that we can do better. :-D

Alex 

