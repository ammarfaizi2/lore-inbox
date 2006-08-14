Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751924AbWHNH6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbWHNH6U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 03:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751925AbWHNH6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 03:58:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42217 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751924AbWHNH6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 03:58:20 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060813133935.b0c728ec.akpm@osdl.org> 
References: <20060813133935.b0c728ec.akpm@osdl.org>  <20060813012454.f1d52189.akpm@osdl.org> 
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>,
       David Howells <dhowells@redhat.com>, Ian Kent <raven@themaw.net>
Subject: Re: 2.6.18-rc4-mm1 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 14 Aug 2006 08:58:02 +0100
Message-ID: <3066.1155542282@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> This kernel breaks autofs /net handling.  Bisection shows that the bug is
> introduced by git-nfs.patch.

What's your autofs setup?  What gets mounted on /net/bix?  Is it "bix:/"?

David
