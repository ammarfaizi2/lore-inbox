Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbTEMT4A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 15:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbTEMTz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 15:55:59 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:649 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262547AbTEMTzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 15:55:54 -0400
Date: Tue, 13 May 2003 22:07:43 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: 2.6 must-fix list, v2
In-Reply-To: <20030513165926.GA1170@mars.ravnborg.org>
Message-ID: <Pine.GSO.4.21.0305132203330.13355-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 May 2003, Sam Ravnborg wrote:
> On Tue, May 13, 2003 at 11:50:47AM -0400, Jeff Garzik wrote:
> > mips definitely needs work.  I don't know that there exists a working
> > 2.5 mips port.
> > 
> > I told Ralf I would work on getting it booting on my Indy, and have been
> > slowly working through that.  There is also some mips work in the
> > linux-mips cvs tree.
> 
> If I want to update mips Makefiles to new style - what should be used
> as baseline?
> 
> Linus-BK or a mips cvs somewhere?

There's still almost daily activity in the Linux/MIPS CVS tree, but compared to
mainline, it's a bit outdated (the main trunk is at 2.5.47, the 2.4 branch at
2.4.21-pre4).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


