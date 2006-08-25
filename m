Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWHYIGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWHYIGP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 04:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWHYIGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 04:06:14 -0400
Received: from mail.suse.de ([195.135.220.2]:52705 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751270AbWHYIGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 04:06:13 -0400
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 25 Aug 2006 18:06:15 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17646.44919.838526.267714@cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 000 of 4] md: Introduction
In-Reply-To: message from Andrew Morton on Thursday August 24
References: <20060824173647.19026.patches@notabene>
	<20060824150900.36bd9285.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday August 24, akpm@osdl.org wrote:
> On Thu, 24 Aug 2006 17:40:56 +1000
> NeilBrown <neilb@suse.de> wrote:
> > 
> >  [PATCH 001 of 4] md: Fix recent breakage of md/raid1 array checking
> >  [PATCH 002 of 4] md: Fix issues with referencing rdev in md/raid1.
> >  [PATCH 003 of 4] md: new sysfs interface for setting bits in the write-intent-bitmap
> >  [PATCH 004 of 4] md: Remove unnecessary variable x in stripe_to_pdidx().
> 
> The second patch is against -mm and doesn't come within a mile of applying
> to mainline.

Bother ... 
I'll get you a really-truly good patch after the weekend :-(

NeilBrown
