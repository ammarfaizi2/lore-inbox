Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbTEMP0Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbTEMP0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:26:23 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:49672 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261566AbTEMP0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:26:11 -0400
Date: Tue, 13 May 2003 16:38:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 must-fix list, v2
Message-ID: <20030513163854.A27407@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030512155417.67a9fdec.akpm@digeo.com> <20030512155511.21fb1652.akpm@digeo.com> <1052834227.432.30.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1052834227.432.30.camel@dhcp22.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Tue, May 13, 2003 at 02:57:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 02:57:08PM +0100, Alan Cox wrote:
> > - ACPI needs the relax patches merging to work on lots of laptops
> 
> Working in 2.4.21-ac, Toshiba cheap laptops now run a treat. Forward
> port looks like a patch command
> 
> 
> Other items:
> 
> PC9800 is not fully merged - most of this I think is 2.7 stuff but a few
> bits might be 2.6 candidate
> 
> SH3/SH3-64 need resynching, as do some other ports. No impact on
> mainstream platforms hopefully

That brings up another issue:  what ports do regularly work with 2.5
mainline?  I've been working with David to get all those core changes ia64
needs (and there's still a lot) sorted out so maybe 2.6 will work out of
the box.  I guess some other arches (parisc, mips?) will need similar
work.

