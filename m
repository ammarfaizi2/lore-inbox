Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWCBRdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWCBRdR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 12:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWCBRdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 12:33:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33983 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932273AbWCBRdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 12:33:16 -0500
Date: Thu, 2 Mar 2006 09:31:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: dhowells@redhat.com, torvalds@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Permit NFS superblock sharing [try #2]
Message-Id: <20060302093133.46618419.akpm@osdl.org>
In-Reply-To: <1706.1141297446@warthog.cambridge.redhat.com>
References: <20060301162113.774d1745.akpm@osdl.org>
	<20060301173617.16639.83553.stgit@warthog.cambridge.redhat.com>
	<1706.1141297446@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > Here's Trond's current diff:
> 
> Where?
> 

Each git tree in -mm has the origin at the start of the patch.  So the
first line of
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm1/broken-out/git-nfs.patch
is

GIT 1e28855867c31925e2ffa3a8acf16bb3ad8b634c git://git.linux-nfs.org/pub/linux/nfs-2.6.git

That's "GIT commit-id URL".
