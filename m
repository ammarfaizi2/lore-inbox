Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263104AbRFCOCn>; Sun, 3 Jun 2001 10:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263102AbRFCOCW>; Sun, 3 Jun 2001 10:02:22 -0400
Received: from zeus.kernel.org ([209.10.41.242]:64401 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262945AbRFCOCN>;
	Sun, 3 Jun 2001 10:02:13 -0400
Date: Sun, 3 Jun 2001 17:59:11 +0400
From: Oleg Drokin <green@linuxhacker.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac7
Message-ID: <20010603175911.A1143@linuxhacker.ru>
In-Reply-To: <200106030746.f537kSZ12820@linuxhacker.ru> <E156VvF-0004D1-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E156VvF-0004D1-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Jun 03, 2001 at 12:19:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sun, Jun 03, 2001 at 12:19:52PM +0100, Alan Cox wrote:
> > AC> 2.4.5-ac7
> > AC> o       Make USB require PCI                            (me)
> > Huh?!
> > How about people from StrongArm sa11x0 port, who have USB host controller (in
> > sa1111 companion chip) but do not have PCI?
> The strongarm doesnt have a USB master but a slave.
SA11x0 have USB slave, but once you add sa1111 companion chip,
you have OHCI compliant USB master, too (and still no PCI)

> > How about ISA USB host controllers?
> They do not exist. 
Hm. I though I have seen some, but not sure right now.
I'll tell you if I will be able to find any.

Bye,
    Oleg
