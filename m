Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbVA0BXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVA0BXj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 20:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbVA0BUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 20:20:08 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:50593 "EHLO
	postbox.bitmover.com") by vger.kernel.org with ESMTP
	id S262440AbVA0BPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 20:15:08 -0500
Date: Wed, 26 Jan 2005 17:14:22 -0800
From: Larry McVoy <lm@bitmover.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>, CVSps@dm.cobite.com,
       linux-kernel@vger.kernel.org, Andreas Gruenbacher <agruen@suse.de>
Subject: Re: kernel CVS troubles with cvsps
Message-ID: <20050127011422.GA15999@bitmover.com>
Mail-Followup-To: Larry McVoy <lm@bitmover.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Catalin Marinas <catalin.marinas@arm.com>, CVSps@dm.cobite.com,
	linux-kernel@vger.kernel.org, Andreas Gruenbacher <agruen@suse.de>
References: <20050125164203.GY7587@dualathlon.random> <tnxsm4po2o6.fsf@arm.com> <20050125190958.GC7587@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050125190958.GC7587@dualathlon.random>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're a little busy right now, we'll try and get to this.

On Tue, Jan 25, 2005 at 08:09:58PM +0100, Andrea Arcangeli wrote:
> On Tue, Jan 25, 2005 at 05:10:17PM +0000, Catalin Marinas wrote:
> > I noticed this problem some time ago when trying to see whether the
> > darcs repository is consistent with the BK one:
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=110026570201544&w=2
> > 
> > A solution is to use the "(Logical change ...)" string within each
> > file's commit log instead of the date (I realised that it is simpler
> > to write a shell script to generate the diffs rather than modifying
> > cvsps).
> 
> Thanks for the confirmation. To me this hour difference looks like a bug
> in bkcvs. It would be nice to get it fixed so we don't have to
> workaround it in cvsps or hack around more scripts.
> 
> Thanks.

-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
