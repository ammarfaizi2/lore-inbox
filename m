Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030414AbWHORW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030414AbWHORW1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 13:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030415AbWHORW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 13:22:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46770 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030414AbWHORW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 13:22:26 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1155662009.5939.1.camel@localhost> 
References: <1155662009.5939.1.camel@localhost>  <1155595768.5656.26.camel@localhost> <20060813012454.f1d52189.akpm@osdl.org> <20060813133935.b0c728ec.akpm@osdl.org> <27792.1155660919@warthog.cambridge.redhat.com> 
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>
Subject: Re: 2.6.18-rc4-mm1 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 15 Aug 2006 18:22:16 +0100
Message-ID: <29567.1155662536@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> The relevant patches are

Yes... those fix the atomic counter problem, thanks.  It appears that patches
006 & 007 are already in the -mm1 tree.

David
