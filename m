Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752069AbWCBWKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbWCBWKz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 17:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752070AbWCBWKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 17:10:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6574 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752069AbWCBWKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 17:10:53 -0500
Date: Thu, 2 Mar 2006 14:07:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: akpm@osdl.org, steved@redhat.com, trond.myklebust@fys.uio.no,
       aviro@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Permit NFS superblock sharing [try #3]
In-Reply-To: <20060302213356.7282.26463.stgit@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0603021405540.22647@g5.osdl.org>
References: <20060302213356.7282.26463.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Mar 2006, David Howells wrote:
> 
> Following discussion with Al Viro, the following changes [try #2] have been
> made to the previous attempt at this set of patches:

Btw, I'd like Al to ack/nack the VFS-specific part, but if he does so, I 
can apply those early in the post.2.6.16-season, so that then the NFS 
specific parts can be decided on independently..

		Linus
