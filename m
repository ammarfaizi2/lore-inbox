Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264176AbTJOTYP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 15:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264180AbTJOTYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 15:24:15 -0400
Received: from [80.88.36.193] ([80.88.36.193]:62889 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264176AbTJOTYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 15:24:14 -0400
Date: Wed, 15 Oct 2003 21:24:10 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Valdis.Kletnieks@vt.edu
cc: Erik Mouw <erik@harddisk-recovery.com>,
       Nikita Danilov <Nikita@Namesys.COM>, Josh Litherland <josh@temp123.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Transparent compression in the FS 
In-Reply-To: <200310151914.h9FJEM5H013940@turing-police.cc.vt.edu>
Message-ID: <Pine.GSO.4.21.0310152122370.21423-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Oct 2003 Valdis.Kletnieks@vt.edu wrote:
> On Wed, 15 Oct 2003 21:03:35 +0200, Geert Uytterhoeven said:
> >   - 1989: Amiga 500, 7.14 MHz 68000, expensive SCSI disk, 675 KB/s
> >   - 1992: Amiga 4000, 25 MHz 68040, IDE, 1.8 MB/s (SCSI with 5 MB/s should ha
> ve
> >     been possible)
> >   - 1998: CHRP, 200 MHz 604e, UW-SCSI, 17 MB/s
> > 
> > The third CPU is ca. 25 times faster than the second (both in BogoMIPS as
> > kernel cross-compiles). The disk isn't 25 faster, though.
> 
> %  dc
> 3 k 17 .675 / p
> 25.185
> ^D
> 
> Huh?

You're comparing the _third_ disk to the _first_. If you want to do that,
please take note that the 68040 is a lot faster than the 68000, too.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

