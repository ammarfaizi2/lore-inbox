Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317830AbSGPMxD>; Tue, 16 Jul 2002 08:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317831AbSGPMxD>; Tue, 16 Jul 2002 08:53:03 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:24303 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317830AbSGPMw7>; Tue, 16 Jul 2002 08:52:59 -0400
Subject: Re: Tyan s2466 stability
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: root@chaos.analogic.com
Cc: SCoTT SMeDLeY <ss@aaoepp.aao.gov.au>, linux-kernel@vger.kernel.org,
       ss@aao.gov.au
In-Reply-To: <Pine.LNX.3.95.1020716073755.7363A-100000@chaos.analogic.com>
References: <Pine.LNX.3.95.1020716073755.7363A-100000@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 16 Jul 2002 15:05:45 +0100
Message-Id: <1026828345.1688.52.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-16 at 12:58, Richard B. Johnson wrote:
> We got one here about two weeks ago. It had 2 AMD processors plus
> 2 'sticks' of RAM (Don't know how much). It was originally tested
> on an IDE drive booting Windows/2000. It worked, but a CPU had to
> be removed because W$ trashes drives when using two CPUs.

More likely your set up was faulty

> I got to play with it for an hour. I put one of my BusLogic SCSI
> controllers in one of the 33MHz slots and booted Linux off an existing

Sounds like hardware/PSU stuff to me

> Nevertheless, I was entirely unimpressed with this "MPX" board. It
> didn't have built-in SCSI like older Tyan boards that I currently use
> and it didn't work very well. My AGP graphics card (G-Force) didn't
> work either (in graphics) although I'm told that 'newer' ones do.

I'm very happy with my MPX based board. The docs sucked, the BIOS
socked, the lack of onboard USB sucked, but the rest is very nice and it
seems stable enough.

Power (430W PSU or bigger - and the right ones to get sufficient current
on low voltage lines) and heat are big problems. I'm very happy with
mine as a server box. As a desktop, or living in the same room as me I'd
say definitely not.

As to the lack of SCSI. I have an Adaptec/Dell Obsidian 4 port 64bit PCI
SCSI controller plugged into it. It outperforms onboard scsi controllers
so I don't feel the need for an onboard scsi controller to chain CD-ROMS
too.

