Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWCIRKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWCIRKe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 12:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWCIRKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 12:10:34 -0500
Received: from pat.uio.no ([129.240.130.16]:35004 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750726AbWCIRKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 12:10:34 -0500
Subject: Re: [PATCH 000 of 14] knfsd: Introduction
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060309174755.24381.patches@notabene>
References: <20060309174755.24381.patches@notabene>
Content-Type: text/plain
Date: Thu, 09 Mar 2006 12:10:11 -0500
Message-Id: <1141924212.8293.52.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.037, required 12,
	autolearn=disabled, AWL 1.78, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 17:51 +1100, NeilBrown wrote:
>  [PATCH 000 of 14] knfsd: Introduction
>  [PATCH 001 of 14] knfsd: Change the store of auth_domains to not be a 'cache'.
>  [PATCH 002 of 14] knfsd: Break the hard linkage from svc_expkey to svc_export
>  [PATCH 003 of 14] knfsd: Get rid of 'inplace' sunrpc caches
>  [PATCH 004 of 14] knfsd: Create cache_lookup function instead of using a macro to declare one.
>  [PATCH 005 of 14] knfsd: Convert ip_map cache to use the new lookup routine.
>  [PATCH 006 of 14] knfsd: Use new cache_lookup for svc_export
>  [PATCH 007 of 14] knfsd: Use new cache_lookup for svc_expkey cache.
>  [PATCH 008 of 14] knfsd: Use new sunrpc cache for rsi cache
>  [PATCH 009 of 14] knfsd: Use new cache code for rsc cache
>  [PATCH 010 of 14] knfsd: Use new cache code for name/id lookup caches
>  [PATCH 011 of 14] knfsd: An assortment of little fixes to the sunrpc cache code.
>  [PATCH 012 of 14] knfsd: Remove DefineCacheLookup
>  [PATCH 013 of 14] knfsd: Unexport cache_fresh and fix a small race.
>  [PATCH 014 of 14] knfsd: Convert sunrpc_cache to use krefs

Any plans to update Documentation/rpc-cache.txt?

Cheers,
  Trond

