Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030371AbWHOQj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030371AbWHOQj6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 12:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030383AbWHOQj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 12:39:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41362 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030371AbWHOQj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 12:39:57 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1155595768.5656.26.camel@localhost> 
References: <1155595768.5656.26.camel@localhost>  <20060813012454.f1d52189.akpm@osdl.org> <20060813133935.b0c728ec.akpm@osdl.org> 
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       David Howells <dhowells@redhat.com>, Ian Kent <raven@themaw.net>
Subject: Re: 2.6.18-rc4-mm1 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 15 Aug 2006 17:39:37 +0100
Message-ID: <26190.1155659977@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> as well as a few dentry leaks that were introduced by David's
> nfs_alloc_client().

I'm really quite surprised that I haven't seen these bugs.

Acked-By: David Howells <dhowells@redhat.com>
