Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279061AbRJVW6v>; Mon, 22 Oct 2001 18:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279054AbRJVW6d>; Mon, 22 Oct 2001 18:58:33 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:35970
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S279050AbRJVW4s>; Mon, 22 Oct 2001 18:56:48 -0400
Date: Mon, 22 Oct 2001 15:56:17 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Hollis Blanchard <hollis-lists@austin.rr.com>,
        Giuliano Pochini <pochini@denise.shiny.it>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: hfs cdrom broken in 2.4.13pre
Message-ID: <20011022155617.B6673@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <B7FA0929.12F5%hollis-lists@austin.rr.com> <E15vnvD-0003jl-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15vnvD-0003jl-00@the-village.bc.nu>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2001 at 11:51:51PM +0100, Alan Cox wrote:
> 
> > on 22/10/01 4:44 PM, Alan Cox at alan@lxorguk.ukuu.org.uk wrote:
> > >
> > >> Kernel 2.4.13pre1 on powerpc. I can no longer mount HFS-formatted cdroms.
> > >> The last kernel I'm sure it worked fine is 2.4.7
> > >
> > > Mount it over loopback device.
> >
> > Why has that become necessary?
> 
> Primarily because the glue in the middle isnt covering up for your CD-ROM
> any more.

No, really.  What's changed to break HFS cdrom support?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
