Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130483AbQK2Cjx>; Tue, 28 Nov 2000 21:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130383AbQK2Cje>; Tue, 28 Nov 2000 21:39:34 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55874 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S129703AbQK2Cjc>; Tue, 28 Nov 2000 21:39:32 -0500
Subject: Re: XFree 4.0.1/NVIDIA 0.9-5/2.4.0-testX/11 woes [solved]
To: vkire@pixar.com (Kiril Vidimce)
Date: Wed, 29 Nov 2000 02:08:42 +0000 (GMT)
Cc: goemon@anime.net (Dan Hollis), alan@lxorguk.ukuu.org.uk (Alan Cox),
        odd@findus.dhs.org (Petter Sundlöf),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0011281758230.1353-100000@nevena.pixar.com> from "Kiril Vidimce" at Nov 28, 2000 06:01:25 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E140wft-0005Mx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 28 Nov 2000, Dan Hollis wrote:
> > Dont forget the nvidia driver is completely SMP broken. As in, trash your
> > filesystems broken.
> 
> Not true. It works for us with no problems on a number of SMP boxes 
> running 2.2.{14,16}. I don't know about 2.4.x.

Dan is not the only one to report it totally trashing a machine and file systems
SMP. So I suspect there is something there , but I don't know what (or care).
I've seen other demos of bugs in the nv driver, long standing ones and
reading the mangled code you can see bugs even in their mangled code
without looking too hard.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
