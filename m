Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbVCAJSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbVCAJSQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 04:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbVCAJSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 04:18:16 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:7577 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261834AbVCAJSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 04:18:10 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Brad Campbell <brad@wasp.net.au>
Date: Tue, 1 Mar 2005 20:18:03 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16932.13131.973765.36917@cse.unsw.edu.au>
Cc: lkml <linux-kernel@vger.kernel.org>,
       RAID Linux <linux-raid@vger.kernel.org>
Subject: Re: Raid-6 hang on write.
In-Reply-To: message from Brad Campbell on Tuesday March 1
References: <421DE9A9.4090902@wasp.net.au>
	<421F4629.5080309@wasp.net.au>
	<16930.45319.682534.351648@cse.unsw.edu.au>
	<422412AB.8080907@wasp.net.au>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday March 1, brad@wasp.net.au wrote:
> Neil Brown wrote:
> > 
> > Could you please confirm if there is a problem with
> >     2.6.11-rc4-bk4->bk10
> > 
> > as reported, and whether it seems to be the same problem.
> 
> Ok.. are we all ready? I had applied your development patches to all my vanilla 2.6.11-rc4-* 
> kernels. Thus they all exhibited the same problem in the same way as -mm1. <Smacks forehead against 
> wall repeatedly>

Thanks for following through with this so we know exactly where the
problem is ... and isn't.  And admitting your careless mistake in
public is a great example to all the rest of us who are too shy to do
so - thanks :-)

> 
> Oh well, at least we now know about a bug in the -mm patches.
> 

Yes, and very helpful to know it is.  Thanks again.

NeilBrown
