Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030270AbWF0BAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbWF0BAW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 21:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWF0BAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 21:00:21 -0400
Received: from ns.suse.de ([195.135.220.2]:59839 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030270AbWF0BAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 21:00:18 -0400
From: Neil Brown <neilb@suse.de>
To: Andre Tomt <andre@tomt.net>
Date: Tue, 27 Jun 2006 11:00:05 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17568.33557.175846.567743@cse.unsw.edu.au>
Cc: Ronald Lembcke <es186@fen-net.de>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: Bug in 2.6.17 / mdadm 2.5.1
In-Reply-To: message from Andre Tomt on Monday June 26
References: <20060624104745.GA6352@defiant.crash>
	<20060625135926.GA6253@defiant.crash>
	<17567.13099.133933.397389@cse.unsw.edu.au>
	<44A050A0.7010400@tomt.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday June 26, andre@tomt.net wrote:
> Neil Brown wrote:
> <snip>
> > Alternately you can apply the following patch to the kernel and
> > version-1 superblocks should work better.
> 
> -stable material?

Maybe.  I'm not sure it exactly qualifies, but I might try sending it
to them and see what they think.

NeilBrown
