Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132466AbQLJBkW>; Sat, 9 Dec 2000 20:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132672AbQLJBkM>; Sat, 9 Dec 2000 20:40:12 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2056 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132466AbQLJBj6>; Sat, 9 Dec 2000 20:39:58 -0500
Subject: Re: Linux 2.2.18 almost...
To: rothwell@holly-springs.nc.us (Michael Rothwell)
Date: Sun, 10 Dec 2000 01:11:54 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3A32C128.1ED29FA2@holly-springs.nc.us> from "Michael Rothwell" at Dec 09, 2000 06:32:56 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E144v1w-00060q-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The patch I intend to be 2.2.18 is out as 2.2.18pre26 in the usual place.
> > I'll move it over tomorrow if nobody reports any horrors, missing files etc
> 
> Fresh 2.2.17, "patch -p1 < /pre-patch-2.2.18-26"
> 
> can't find file to patch at input line 38909
> Perhaps you used the wrong -p or --strip option?
> The text leading up to this was:
> --------------------------
> |diff -u --new-file --recursive --exclude-from /usr/src/exclude
> v2.2.17/arch/i386/vmlinux.lds linux/arch/i386/vmlinux.lds
> |--- v2.2.17/arch/i386/vmlinux.lds	Wed May  3 21:22:13 2000
> |+++ linux/arch/i386/vmlinux.lds	Sat Dec  9 21:23:21 2000

Now you know why I put it out as a pre26 first 8)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
