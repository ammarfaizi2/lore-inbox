Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbUKEUgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUKEUgf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 15:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbUKEUgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 15:36:35 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:27910 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261206AbUKEUgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 15:36:33 -0500
Date: Fri, 5 Nov 2004 21:31:21 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Adam Heath <doogie@debian.org>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Chris Wedgwood <cw@f00f.org>, Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
Message-ID: <20041105203120.GD30993@alpha.home.local>
References: <41894779.10706@techsource.com> <20041103211353.GA24084@infradead.org> <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com> <20041103233029.GA16982@taniwha.stupidest.org> <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com> <418A603A.3030806@nortelnetworks.com> <Pine.LNX.4.58.0411041216240.1229@gradall.private.brainfood.com> <20041105200021.GA30993@alpha.home.local> <Pine.GSO.4.61.0411052128250.23785@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0411052128250.23785@waterleaf.sonytel.be>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 09:28:58PM +0100, Geert Uytterhoeven wrote:
> > Nobody ever claimed that we all spend our time compiling on the target
> > system. I wonder if thas would be possible on a 16 MB/200 MHz MIPS ;-)
> 
> Why not? 16 MB and 200 MHz used to be plenty!

Yes, sorry, I forgot to mention that instead of disk, I only have 8 MB
flash :-) Of course, I could do it over NFS, yes...

Cheers,
Willy

