Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbUKEU3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbUKEU3n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 15:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbUKEU3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 15:29:43 -0500
Received: from witte.sonytel.be ([80.88.33.193]:49916 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261207AbUKEU33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 15:29:29 -0500
Date: Fri, 5 Nov 2004 21:28:58 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Willy Tarreau <willy@w.ods.org>
cc: Adam Heath <doogie@debian.org>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Chris Wedgwood <cw@f00f.org>, Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
In-Reply-To: <20041105200021.GA30993@alpha.home.local>
Message-ID: <Pine.GSO.4.61.0411052128250.23785@waterleaf.sonytel.be>
References: <41894779.10706@techsource.com> <20041103211353.GA24084@infradead.org>
 <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com>
 <20041103233029.GA16982@taniwha.stupidest.org>
 <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com>
 <418A603A.3030806@nortelnetworks.com> <Pine.LNX.4.58.0411041216240.1229@gradall.private.brainfood.com>
 <20041105200021.GA30993@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Nov 2004, Willy Tarreau wrote:
> On Thu, Nov 04, 2004 at 12:17:01PM -0600, Adam Heath wrote:
> > > You're posting to the kernel development list--many people here recompile dozens
> > > of times a day.
> > 
> > So find the fastest computer you have, and use that.  There is no need to
> > compile a kernel on the machine it will be run on.
> 
> Uhh ?
> 
> What are you smoking ? We all have the fastest computers we can buy, and
> since a kernel still takes a few minutes to compile on those computers,
> we try to use the fastest compilers to save *HOURS* at the end of the day.
> Nobody ever claimed that we all spend our time compiling on the target
> system. I wonder if thas would be possible on a 16 MB/200 MHz MIPS ;-)

Why not? 16 MB and 200 MHz used to be plenty!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
