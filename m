Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422665AbWCJA4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422665AbWCJA4G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422666AbWCJA4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:56:06 -0500
Received: from mx1.suse.de ([195.135.220.2]:20628 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422665AbWCJA4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:56:04 -0500
From: Neil Brown <neilb@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: Fri, 10 Mar 2006 11:54:59 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17424.52835.97063.780305@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 000 of 14] knfsd: Introduction
In-Reply-To: message from Trond Myklebust on Thursday March 9
References: <20060309174755.24381.patches@notabene>
	<1141924212.8293.52.camel@lade.trondhjem.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday March 9, trond.myklebust@fys.uio.no wrote:
> On Thu, 2006-03-09 at 17:51 +1100, NeilBrown wrote:
> >  [PATCH 000 of 14] knfsd: Introduction
> >  [PATCH 001 of 14] knfsd: Change the store of auth_domains to not be a 'cache'.
> >  [PATCH 002 of 14] knfsd: Break the hard linkage from svc_expkey to svc_export
> >  [PATCH 003 of 14] knfsd: Get rid of 'inplace' sunrpc caches
> >  [PATCH 004 of 14] knfsd: Create cache_lookup function instead of using a macro to declare one.
> >  [PATCH 005 of 14] knfsd: Convert ip_map cache to use the new lookup routine.
> >  [PATCH 006 of 14] knfsd: Use new cache_lookup for svc_export
> >  [PATCH 007 of 14] knfsd: Use new cache_lookup for svc_expkey cache.
> >  [PATCH 008 of 14] knfsd: Use new sunrpc cache for rsi cache
> >  [PATCH 009 of 14] knfsd: Use new cache code for rsc cache
> >  [PATCH 010 of 14] knfsd: Use new cache code for name/id lookup caches
> >  [PATCH 011 of 14] knfsd: An assortment of little fixes to the sunrpc cache code.
> >  [PATCH 012 of 14] knfsd: Remove DefineCacheLookup
> >  [PATCH 013 of 14] knfsd: Unexport cache_fresh and fix a small race.
> >  [PATCH 014 of 14] knfsd: Convert sunrpc_cache to use krefs
> 
> Any plans to update Documentation/rpc-cache.txt?

What a good idea!  I'll put it on my todo list, thanks.

NeilBrown


