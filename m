Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263726AbRFDSJ3>; Mon, 4 Jun 2001 14:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264114AbRFDSHu>; Mon, 4 Jun 2001 14:07:50 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:4624 "EHLO
	Opus.bloom.county") by vger.kernel.org with ESMTP
	id <S263717AbRFDR5C>; Mon, 4 Jun 2001 13:57:02 -0400
Date: Mon, 4 Jun 2001 10:56:00 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac7
Message-ID: <20010604105600.D18033@opus.bloom.county>
In-Reply-To: <200106030746.f537kSZ12820@linuxhacker.ru> <E156VvF-0004D1-00@the-village.bc.nu> <20010603175911.A1143@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010603175911.A1143@linuxhacker.ru>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, Jun 03, 2001 at 05:59:11PM +0400, Oleg Drokin wrote:

> On Sun, Jun 03, 2001 at 12:19:52PM +0100, Alan Cox wrote:
> > > AC> 2.4.5-ac7
> > > AC> o       Make USB require PCI                            (me)
> > > Huh?!
> > > How about people from StrongArm sa11x0 port, who have USB host controller (in
> > > sa1111 companion chip) but do not have PCI?
> > The strongarm doesnt have a USB master but a slave.
> SA11x0 have USB slave, but once you add sa1111 companion chip,
> you have OHCI compliant USB master, too (and still no PCI)

I tried replying to this yesterday and it didn't get through, so..
All of the MPC8xx chips can have a USB controller as well (albiet not OHCI
or UHCI) and none of them have PCI either.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
