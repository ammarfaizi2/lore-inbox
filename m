Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261842AbTCGXGf>; Fri, 7 Mar 2003 18:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261844AbTCGXGf>; Fri, 7 Mar 2003 18:06:35 -0500
Received: from palrel12.hp.com ([156.153.255.237]:57004 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id <S261842AbTCGXGe>;
	Fri, 7 Mar 2003 18:06:34 -0500
Date: Fri, 7 Mar 2003 15:17:09 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: acx100_pci.o GPL but only binary version
Message-ID: <20030307231709.GA10152@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote :
> 
> On Fri, 2003-03-07 at 20:17, alx wrote:
> > acx100_pci.o wanna be a linux driver from the TI acx100 chipset.
> > but it doesn't work at all!
> > - First ifconfig SegFault 
> > - Second hangs the machine
> 
> Its a known one. No source, the GPL license appears to be a fiction 
> designed to violate the Linux copyright. I guess someone needs a DMCA
> takedown order in the post

	Actually, the problem is that TI (which we believe is the
author of the driver) doesn't itself distribute this driver, but it
seems that it has misteriously "leaked" on the net and it's just basic
Linux users that are putting it on their web page.
	If you look at the Linux-Wlan mailing list archive, you will
see that this driver also contain code from the linux-wlan-ng driver,
and I don't know yet if they cut'n'paste code from the GPL version or
just bought the development kit from Linux-Wlan.
	Anyway, as this driver doesn't seem to work (check the various
mailing list), I don't think there is any point making a big fuss and
we should politely ask TI (or whoever wrote the driver) to come clear
on this one.

	Have fun...

	Jean

P.S. : And in the Howto, TI is still marked as "unsupported".
