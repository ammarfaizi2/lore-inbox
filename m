Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261673AbSJCPXJ>; Thu, 3 Oct 2002 11:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261672AbSJCPXJ>; Thu, 3 Oct 2002 11:23:09 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:61452 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261667AbSJCPXI>; Thu, 3 Oct 2002 11:23:08 -0400
Date: Thu, 3 Oct 2002 16:28:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@redhat.com>, Greg Ungerer <gerg@snapgear.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.40-ac1
Message-ID: <20021003162835.A23631@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>,
	Greg Ungerer <gerg@snapgear.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021003151707.A17513@infradead.org> <200210031420.g93EK3L07983@devserv.devel.redhat.com> <20021003155122.A20437@infradead.org> <1033658738.28814.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1033658738.28814.7.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Oct 03, 2002 at 04:25:38PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 04:25:38PM +0100, Alan Cox wrote:
> On Thu, 2002-10-03 at 15:51, Christoph Hellwig wrote:
> > Did you actually take a look?  Many files are basically the same and other
> > are just totally stubbed out in nommu.
> 
> Basically but never entirely - if you can see a way to clean that up
> nicely that Linus would accept other than mmnommu then thats even
> better. I couldnt see a way of getting enough ifdefs out of the tree

I'll start feeding patches once I'm back from a small journey

