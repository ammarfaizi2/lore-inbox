Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWHaJ7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWHaJ7A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 05:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWHaJ7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 05:59:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54725 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751411AbWHaJ67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 05:58:59 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060830135503.98f57ff3.akpm@osdl.org> 
References: <20060830135503.98f57ff3.akpm@osdl.org>  <20060830125239.6504d71a.akpm@osdl.org> <20060830193153.12446.24095.stgit@warthog.cambridge.redhat.com> <27414.1156970238@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock sharing [try #13] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 31 Aug 2006 10:58:30 +0100
Message-ID: <9849.1157018310@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> - Send fine-grained incremental patches.  It's OK to do complete
>   replacement patchsets when the code is new, but this stuff is supposed to
>   be stabilised.

I thought the code was still officially *new*.

As I understood things from what you said, you delegated responsibility for my
patches on to Trond, who hasn't taken them yet.  He has further delegated
review responsibility on to Christoph, so I've been consolidating my patches
to make it easier for Christoph (or whoever) to do so.

So, as I understand the situation, my patches won't go anywhere until
Christoph ACKs them and Trond takes them into his tree.  If this isn't so,
please clarify the situation.

David
