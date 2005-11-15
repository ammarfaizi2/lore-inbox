Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbVKOGwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbVKOGwv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 01:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbVKOGwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 01:52:51 -0500
Received: from ns.suse.de ([195.135.220.2]:25793 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932318AbVKOGwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 01:52:50 -0500
From: Neil Brown <neilb@suse.de>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Date: Tue, 15 Nov 2005 17:52:26 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17273.34218.334118.264701@cse.unsw.edu.au>
Cc: Dave Jones <davej@redhat.com>, Lee Revell <rlrevell@joe-job.com>,
       Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
In-Reply-To: message from Jeff V. Merkey on Monday November 14
References: <58MJb-2Sn-37@gated-at.bofh.it>
	<58NvO-46M-23@gated-at.bofh.it>
	<58Rpx-1m6-11@gated-at.bofh.it>
	<58UGF-6qR-27@gated-at.bofh.it>
	<58UQf-6Da-3@gated-at.bofh.it>
	<437933B6.1000503@shaw.ca>
	<1132020468.27215.25.camel@mindpipe>
	<20051115032819.GA5620@redhat.com>
	<43795575.9010904@wolfmountaingroup.com>
	<20051115050658.GA13660@redhat.com>
	<43797E05.5090107@wolfmountaingroup.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday November 14, jmerkey@wolfmountaingroup.com wrote:
> Dave Jones wrote:
> 
> >On Mon, Nov 14, 2005 at 08:26:45PM -0700, Jeff V. Merkey wrote:
> >
> > > NetWare used 16K stacks in kernel by default.
> >
> >unsubscribe netware-kernel
> >  
> >
> 
> Making the point that in 1990, folks had grown beyond 4K stacks in 
> kernels, along with MS DOS 640K Limitations.

But I seem to remember learning in CS101 (or whatever we called it),
that the stack grows down and the heap grows up.
So if 'folks had grown beyond 4K stacks', I guess they must be at 2K
stacks ?->

NeilBrown

> 
> :-)
> 
> Jeff
