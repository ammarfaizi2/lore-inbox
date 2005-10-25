Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbVJYJz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbVJYJz0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 05:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbVJYJz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 05:55:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12445 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932111AbVJYJzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 05:55:25 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.61.0510241938100.6142@goblin.wat.veritas.com> 
References: <Pine.LNX.4.61.0510241938100.6142@goblin.wat.veritas.com>  <1130168619.19518.43.camel@imp.csi.cam.ac.uk> <1130167005.19518.35.camel@imp.csi.cam.ac.uk> <Pine.LNX.4.61.0502091357001.6086@goblin.wat.veritas.com> <7872.1130167591@warthog.cambridge.redhat.com> <9792.1130171024@warthog.cambridge.redhat.com> 
To: Hugh Dickins <hugh@veritas.com>
Cc: David Howells <dhowells@redhat.com>, Anton Altaparmakov <aia21@cam.ac.uk>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add notification of page becoming writable to VMA ops 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Tue, 25 Oct 2005 10:55:09 +0100
Message-ID: <8181.1130234109@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:

> I've only given it a quick look, it looks pretty good, but too hastily
> thrown together, without understanding of the intervening changes:

I attempted to forward port your patch; unfortunately, I'm not fully
conversant with some of the VM stuff.

> This isn't necessarily wrong, and may be exactly how it was before,

It's as it was in your patch.

I'll try and fix the changes.

David
