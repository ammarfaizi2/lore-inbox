Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272010AbRHVNqZ>; Wed, 22 Aug 2001 09:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272006AbRHVNqP>; Wed, 22 Aug 2001 09:46:15 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14861 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271638AbRHVNqC>; Wed, 22 Aug 2001 09:46:02 -0400
Subject: Re: Qlogic/FC firmware
To: jfbeam@bluetopia.net (Ricky Beam)
Date: Wed, 22 Aug 2001 14:49:09 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.33.0108220844500.6389-100000@sweetums.bluetronic.net> from "Ricky Beam" at Aug 22, 2001 09:29:38 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZYNZ-0001Yc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Amazing *and* unnecessarily complex.  What a bargin!  And it's still going
> to consume that precious 128K even when loaded from usersapce as the driver
> will still need to keep it.  And aren't you one of the Preists of Text in

No. We can jettison it and you know that in fact you commented on using 
__initdata in the non modular case, so stop trolling and if you are going to
be a pain, at least be consistant in your arguments. 

> /proc -- those of the belief in managing everything with 'cat' and 'vi'.

No. That would be Al Viro. 

> >sloppy "who cares about 128K" thinking that leads to several megs
> >disappearing and your OS turning into sludge.
> 
> Way too damn late make that argument.  That snowball has been gaining mass
> and speed for years now.  I would not recommend standing in front of it.

If I was working on Irix maybe, but I'm not. I've got another .5Mb on my
256Mb box I want back in 2.5 as well 8)

> "little problem".  I'm guessing this is a problem for Alphas as well.  Altho'

Alpha's have x86 emulation in the boot loaders. Thats a not-nice solution to
most of the PC worlds evils but works out.

> >Take that one up with Linus. I didn't merge it originally
> 
> No, you take it up with Linus (and the Qlogic maintainer) as you are the nut
> removing it ... and introducing a great big question mark around the stability
> of the Qlogic FC driver.

See previous four conversations on this. Licensing matters. 

Case closed

Alan
