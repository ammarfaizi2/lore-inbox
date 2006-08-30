Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751525AbWH3Um7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbWH3Um7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 16:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbWH3Um7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 16:42:59 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:65504 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751511AbWH3Um6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 16:42:58 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060830125239.6504d71a.akpm@osdl.org> 
References: <20060830125239.6504d71a.akpm@osdl.org>  <20060830193153.12446.24095.stgit@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock sharing [try #13] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 30 Aug 2006 21:37:18 +0100
Message-ID: <27414.1156970238@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> > These patches add local caching for network filesystems such as NFS and AFS.
> 
> <fercrissake>
> 
> Not interested.  Please go learn quilt, send incremental patches.

What's quilt able to do that StGIT can't?  AFAICT from quilt's manpage, it
can't mail incremental patches, so how does it help anyway?

David
