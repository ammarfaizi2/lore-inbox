Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263760AbRFCV27>; Sun, 3 Jun 2001 17:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263761AbRFCVWh>; Sun, 3 Jun 2001 17:22:37 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:25868
	"EHLO Opus.bloom.county") by vger.kernel.org with ESMTP
	id <S263694AbRFCUwd>; Sun, 3 Jun 2001 16:52:33 -0400
Date: Sun, 3 Jun 2001 13:50:55 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Oleg Drokin <green@linuxhacker.ru>, Alan Cox <laughing@shared-source.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac7
Message-ID: <20010603135055.C6375@opus.bloom.county>
In-Reply-To: <E156VvF-0004D1-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E156VvF-0004D1-00@the-village.bc.nu>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, Jun 03, 2001 at 12:19:52PM +0100, Alan Cox wrote:
> > AC> 2.4.5-ac7
> > AC> o       Make USB require PCI                            (me)
> > Huh?!
> > How about people from StrongArm sa11x0 port, who have USB host controller (in
> > sa1111 companion chip) but do not have PCI?
> 
> The strongarm doesnt have a USB master but a slave.

Er, eh?

> > Probably there are more such embedded architectures with USB controllers,
> > but not PCI bus.
> 
> Currently we don't support any of them.

I don't know off the top of my head, but I don't _think_ the MPC823 has a
USB controller but not off of a PCI bus..

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
