Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263213AbRFCO5g>; Sun, 3 Jun 2001 10:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263210AbRFCO50>; Sun, 3 Jun 2001 10:57:26 -0400
Received: from [213.128.193.148] ([213.128.193.148]:24337 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S263160AbRFCOwP>;
	Sun, 3 Jun 2001 10:52:15 -0400
Date: Sun, 3 Jun 2001 18:51:42 +0400
From: Oleg Drokin <green@linuxhacker.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk@arm.linux.org.uk>, Alan Cox <laughing@shared-source.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac7
Message-ID: <20010603185142.A1474@linuxhacker.ru>
In-Reply-To: <20010603133333.A25478@flint.arm.linux.org.uk> <E156Z88-0004O1-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E156Z88-0004O1-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Jun 03, 2001 at 03:45:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sun, Jun 03, 2001 at 03:45:24PM +0100, Alan Cox wrote:
> > Alan, a StrongARM 11x0 with its companion SA11x1 chip is a USB master.
> > Last time I looked, it was supported:
> > + * usb-ohci-sa1111.h
> So the SA1110 has PCI bus ? Or at least equivalent logic ?
SA1110 do not have PCI bus. Neither do SA1111.
I am not sure what kind of equivalent logic you mean.
All IO addresses are fixed and specified in chip spec.

Bye,
    Oleg
