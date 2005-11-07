Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965399AbVKGWNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965399AbVKGWNh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 17:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965400AbVKGWNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 17:13:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:31671 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965399AbVKGWNf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 17:13:35 -0500
From: Neil Brown <neilb@suse.de>
To: Andre Noll <maan@systemlinux.org>
Date: Tue, 8 Nov 2005 09:13:29 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17263.53641.390583.901877@cse.unsw.edu.au>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [NFS] Re: BUG: soft lockup detected on CPU#0! (linux-2.6.14)
In-Reply-To: message from Andre Noll on Monday November 7
References: <20051106193142.GD26862@skl-net.de>
	<17262.31781.497775.640424@cse.unsw.edu.au>
	<20051106225138.GF26862@skl-net.de>
	<20051107161605.GH26862@skl-net.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday November 7, maan@systemlinux.org wrote:
> On 23:51, Andre Noll wrote:
> > > The following patch might fix it.  Please let me know the result.
> > 
> > Patch applied and rebooted. The box currently compiles glibc and
> > firefox in parallel. No problems so far.
> 
> Just want to confirm that your patch indeed fixed the problem. I
> can't reproduce the bug message any more.

Excellent, thanks.
I'll make sure the patch gets in to an upcoming release.

NeilBrown
