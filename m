Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262901AbSKYSH3>; Mon, 25 Nov 2002 13:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263256AbSKYSH3>; Mon, 25 Nov 2002 13:07:29 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:28892 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262901AbSKYSH2>;
	Mon, 25 Nov 2002 13:07:28 -0500
Date: Mon, 25 Nov 2002 19:13:52 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Josh Myer <jbm@joshisanerd.com>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Tridentfb updates?
Message-ID: <20021125181352.GF11884@suse.de>
References: <Pine.LNX.4.44.0211221146240.30881-100000@blessed.joshisanerd.com> <1038185518.28491.24.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1038185518.28491.24.camel@irongate.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25 2002, Alan Cox wrote:
> On Fri, 2002-11-22 at 17:49, Josh Myer wrote:
> > Hi,
> > 
> > I've got an EPIA board, with a trident CyberBlade chipset. Does anyone
> > have doco on this chipset? The random Xfree stuff available from VIA is
> > less-than-enlightening (I'm not familiar with X internals).
> > 
> > I'm basically just interested in getting FB working for NTSC output.
> 
> The chipset docs are freely downloadable from VIA (including the 3d
> info). The TV on the epia is a seperate chip. I use the vesa mode switch
> to program that

For the record, a friend of mine pointed me to:

http://epiafb.sourceforge.net/

today. fb sort of works, the mode initialization doesn't get the mode
quite right it seems, but a manual fbset works for me afterwards.

-- 
Jens Axboe

