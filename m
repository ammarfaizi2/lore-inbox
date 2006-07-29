Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWG2Qb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWG2Qb1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 12:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWG2Qb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 12:31:27 -0400
Received: from pat.uio.no ([129.240.10.4]:62961 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751306AbWG2Qb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 12:31:26 -0400
Subject: Re: [PATCH 00/30] Permit filesystem local caching and NFS
	superblock sharing [try #11]
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, steved@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
In-Reply-To: <24563.1154171551@warthog.cambridge.redhat.com>
References: <20060728230540.7358b435.akpm@osdl.org>
	 <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
	 <24563.1154171551@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Sat, 29 Jul 2006 12:30:47 -0400
Message-Id: <1154190647.5784.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5, required 12,
	autolearn=disabled, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-29 at 12:12 +0100, David Howells wrote:

> > The first 25 patches are, as far as I can tell, already in Trond's tree.
> > Whether Trond has the correct versions of these is now anybody's guess...
> 
> He hasn't told me of any changes, but that doesn't mean he hasn't made any, I
> suppose.

The only changes I made were to add a signed-off-by line. Unless you've
made changes after we talked at OLS, then the patches should be
identical.

Cheers,
  Trond

