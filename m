Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266613AbUIMNIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266613AbUIMNIt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 09:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266689AbUIMNIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 09:08:49 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:40104 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S266613AbUIMNIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 09:08:45 -0400
Date: Mon, 13 Sep 2004 15:08:44 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Debian GNU/Linux m68k <debian-68k@lists.debian.org>,
       uClinux list <uclinux-dev@uclinux.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: `new' syscalls for m68k
Message-ID: <20040913130844.GB1774@MAIL.13thfloor.at>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Debian GNU/Linux m68k <debian-68k@lists.debian.org>,
	uClinux list <uclinux-dev@uclinux.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0409102250300.24607@anakin> <1094852893.18235.5.camel@localhost.localdomain> <20040912212244.GC24240@MAIL.13thfloor.at> <Pine.GSO.4.58.0409131316430.21429@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0409131316430.21429@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 01:17:10PM +0200, Geert Uytterhoeven wrote:
> On Sun, 12 Sep 2004, Herbert Poetzl wrote:
> > On Fri, Sep 10, 2004 at 10:48:16PM +0100, Alan Cox wrote:
> > > On Gwe, 2004-09-10 at 21:57, Geert Uytterhoeven wrote:
> > > >   - What about sys_vserver()?
> >
> > I would be happy to add a syscall reservation
> > to the list of already reserved syscalls for
> > i386, x86_64, s390, sparc/64, sh3/4, ppc/64
> > and mips * ...
> 
> Also for m68k?

of course, linux-vserver is except for 2-3 tiny 
arch specific modifications which might go away
sooner or later (ptrace and uname) completely
arch agnostic, so there should be no problem
using it on m68k ...

TIA,
Herbert

> Gr{oetje,eeting}s,
> 
> 						Geert
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
