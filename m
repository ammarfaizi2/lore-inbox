Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263877AbRFDSua>; Mon, 4 Jun 2001 14:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263120AbRFDSuU>; Mon, 4 Jun 2001 14:50:20 -0400
Received: from modemcable084.137-200-24.mtl.mc.videotron.ca ([24.200.137.84]:19196
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S263878AbRFDSuE>; Mon, 4 Jun 2001 14:50:04 -0400
Date: Mon, 4 Jun 2001 14:49:45 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: <nico@xanadu.home>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Tom Rini <trini@kernel.crashing.org>, Oleg Drokin <green@linuxhacker.ru>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.5-ac7
In-Reply-To: <E156ydR-0005hH-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0106041446010.7929-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Jun 2001, Alan Cox wrote:

> > I tried replying to this yesterday and it didn't get through, so..
> > All of the MPC8xx chips can have a USB controller as well (albiet not OHCI
> > or UHCI) and none of them have PCI either.
>
> Ok I will change a future -ac to check PCI for OHCI/UHCI and then check
> 'any host controller' for the devices

Actually, the SA1111 is rather OHCI even if not PCI.

But still you shouldn't bother with those details until the patch is
ever sent to you.  It's not like if the proper change was hard to add to the
SA1111 patch.


Nicolas

