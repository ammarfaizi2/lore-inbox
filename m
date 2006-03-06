Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWCFN6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWCFN6U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 08:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWCFN6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 08:58:20 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:31145 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1750788AbWCFN6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 08:58:19 -0500
Date: Mon, 6 Mar 2006 14:57:48 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Permit NFS superblock sharing [try #3]
Message-ID: <20060306135748.GA10519@wohnheim.fh-wedel.de>
References: <20060304041647.6894ca62.akpm@osdl.org> <20060302213356.7282.26463.stgit@warthog.cambridge.redhat.com> <29932.1141646154@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29932.1141646154@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 March 2006 11:55:54 +0000, David Howells wrote:
> 
> > The kernel won't compile with just patch #1 applied.  Patches shouldn't go
> > into git in that manner.
> 
> It's easier to review them in that manner. If you don't think git is up to it,
> then combine them.

Funny, I would have assumed that all patches should leave the kernel
in a state where it'd at least compile and boot.  Since when are
patches split for review an accepted exception?

Jörn

-- 
More computing sins are committed in the name of efficiency (without
necessarily achieving it) than for any other single reason - including
blind stupidity.
-- W. A. Wulf 
