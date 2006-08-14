Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752044AbWHNSca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbWHNSca (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 14:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbWHNSca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 14:32:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61126 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752044AbWHNSc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 14:32:29 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060813133935.b0c728ec.akpm@osdl.org> 
References: <20060813133935.b0c728ec.akpm@osdl.org>  <20060813012454.f1d52189.akpm@osdl.org> 
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>,
       David Howells <dhowells@redhat.com>, Ian Kent <raven@themaw.net>
Subject: Re: 2.6.18-rc4-mm1 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 14 Aug 2006 19:32:19 +0100
Message-ID: <10791.1155580339@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> sony:/home/akpm> showmount -e bix
> Export list for bix:
> /           *
> /usr/src    *
> /mnt/export *

What's in your /etc/exports file?

David
