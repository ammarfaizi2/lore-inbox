Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263061AbSJGOAV>; Mon, 7 Oct 2002 10:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263063AbSJGOAV>; Mon, 7 Oct 2002 10:00:21 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:15343 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263061AbSJGOAU>; Mon, 7 Oct 2002 10:00:20 -0400
Subject: Re: The end of embedded Linux?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Abraham vd Merwe <abraham@2d3d.co.za>
Cc: Russell King <rmk@arm.linux.org.uk>, "David S. Miller" <davem@redhat.com>,
       simon@baydel.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021007141053.B14444@crystal.2d3d.co.za>
References: <20021005.212832.102579077.davem@redhat.com>
	<1033923206.21282.28.camel@irongate.swansea.linux.org.uk>
	<3DA16A9B.7624.4B0397@localhost>
	<20021007.033644.85392050.davem@redhat.com>
	<20021007125755.A5381@flint.arm.linux.org.uk> 
	<20021007141053.B14444@crystal.2d3d.co.za>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Oct 2002 15:12:45 +0100
Message-Id: <1033999965.25063.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-07 at 13:10, Abraham vd Merwe wrote:
> Hi Russell!
> 
> > And as final proof, the solution taken by two embedded companies is
> > to develop two completely separate cs89x0 driver from the existing one
> > (and then pick one/merge them) rather than fixing stuff in the way
> > suggested by Alan.
> 
> Hey, the original cs89x0 driver were just too ugly to actually work on -
> It was much more productive to just start from scratch (;

But in that case if you have a better cs89x0 driver that works well and
works on multiple platforms, 2.5 is the right time to throw it at the
tree and bury the current one

