Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWHQMdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWHQMdj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 08:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWHQMdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 08:33:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45533 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932339AbWHQMdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 08:33:38 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <3930.1155816809@warthog.cambridge.redhat.com> 
References: <3930.1155816809@warthog.cambridge.redhat.com>  <20060817004219.44c45bbd.akpm@osdl.org> <1155743399.5683.13.camel@localhost> <20060813133935.b0c728ec.akpm@osdl.org> <20060813012454.f1d52189.akpm@osdl.org> <5910.1155741329@warthog.cambridge.redhat.com> <13319.1155744959@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, aviro@redhat.com,
       Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] NFS: Replace null dentries that appear in readdir's list 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 17 Aug 2006 13:33:30 +0100
Message-ID: <4448.1155818010@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> Andrew Morton <akpm@osdl.org> wrote:
> 
> > VFS: Busy inodes after unmount of 0:15. Self-destruct in 5 seconds.  Have a
> > nice day...

Also, what patches do you have applied?  Just the NFS patches or all the -mm
patches?

David
