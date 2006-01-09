Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbWAJTW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWAJTW0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 14:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWAJTW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 14:22:26 -0500
Received: from hera.kernel.org ([140.211.167.34]:30152 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751325AbWAJTWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 14:22:25 -0500
Date: Mon, 9 Jan 2006 14:35:01 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "G.W. Haywood" <ged@jubileegroup.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ne2k PCI/ISA documentation: improved cross-reference.
Message-ID: <20060109163501.GA7029@dmt.cnet>
References: <Pine.LNX.4.58.0512291301420.2118@mail3.jubileegroup.co.uk> <9a8748490512290553g448d1e28w65dad834cd08e1a7@mail.gmail.com> <Pine.LNX.4.58.0512291520250.6219@mail3.jubileegroup.co.uk> <200512292149.55237.jesper.juhl@gmail.com> <Pine.LNX.4.58.0601071459440.8957@mail3.jubileegroup.co.uk> <20060109130655.GA4687@dmt.cnet> <Pine.LNX.4.58.0601091642160.20758@mail3.jubileegroup.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0601091642160.20758@mail3.jubileegroup.co.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 04:46:09PM +0000, G.W. Haywood wrote:
> Hi Marcelo,
> 
> On Mon, 9 Jan 2006, Marcelo Tosatti wrote:
> 
> > On Sat, Jan 07, 2006 at 03:11:40PM +0000, G.W. Haywood wrote:
> > > From: Ged Haywood <ged@jubileegroup.co.uk>
> > >
> > > Improved reference to PCI ne2k support in ISA ne2k documentation.
> 
> > Appreciate your efforts but the v2.4 tree is under deep maintenance mode
> 
> Sorry, I didn't know.  (And evidently several other people on the LKML
> didn't know either... :)  Does that mean that development is finished
> on the 2.4 tree, or will it switch back to accepting patches at some
> future time?  

Development is definately finished. The maintenance of the stable tree 
at this point should be done to fix critical problems.

So, its accepting patches, but only for critical problems/real bugs.

> There's quite a lot in the Documentation/ directory that could be
> improved (as you probably know:).

Definately - the community has concentrated efforts on the v2.6 tree
for more than 3, 4 years.

linux-2.6.14/drivers/net/Kconfig has the exact same text: 

    If you have a PCI NE2000 card however, say N here and Y to "PCI
    NE2000 support", above. If you have a NE2000 card and are running on
    an MCA system (a bus system used on some IBM PS/2 computers and
    laptops), say N here and Y to "NE/2 (ne2000 MCA version) support",
    below.

Send a patch :)

