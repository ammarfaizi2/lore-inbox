Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWHaR0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWHaR0c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 13:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWHaR0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 13:26:32 -0400
Received: from pat.uio.no ([129.240.10.4]:47610 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932216AbWHaR0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 13:26:31 -0400
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock
	sharing [try #13]
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, steved@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060831102127.8fb9a24b.akpm@osdl.org>
References: <20060830135503.98f57ff3.akpm@osdl.org>
	 <20060830125239.6504d71a.akpm@osdl.org>
	 <20060830193153.12446.24095.stgit@warthog.cambridge.redhat.com>
	 <27414.1156970238@warthog.cambridge.redhat.com>
	 <9849.1157018310@warthog.cambridge.redhat.com>
	 <20060831102127.8fb9a24b.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 13:26:13 -0400
Message-Id: <1157045173.11347.94.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.2, required 12,
	autolearn=disabled, AWL 1.80, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-31 at 10:21 -0700, Andrew Morton wrote:
> If Christoph acks them then I can send them to Trond or Linus, at Trond's
> option.
> 
> Or I can butt out, drop the patches, wait for them to turn up in Trond's
> tree, at your option.

I don't mind pulling them into my tree, but since Christoph had
objections to earlier implementations, and specifically asked me to put
a hold on the non-NFS related patches, then I'd first like an ACK from
him stating that he is now happy with the way those objections have been
handled in the updates.

Cheers,
  Trond

