Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVFVOA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVFVOA6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 10:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbVFVOA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 10:00:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62416 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261283AbVFVOAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 10:00:52 -0400
Date: Wed, 22 Jun 2005 10:00:15 -0400 (EDT)
From: Rik Van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: David Masover <ninja@slaphack.com>
cc: Jeff Garzik <jgarzik@pobox.com>, Hans Reiser <reiser@namesys.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
In-Reply-To: <42B8E834.5030809@slaphack.com>
Message-ID: <Pine.LNX.4.61.0506220959090.28302@chimarrao.boston.redhat.com>
References: <20050620235458.5b437274.akpm@osdl.org> <42B831B4.9020603@pobox.com>
 <42B87318.80607@namesys.com> <20050621202448.GB30182@infradead.org>
 <42B8B9EE.7020002@namesys.com> <42B8BB5E.8090008@pobox.com>
 <42B8E834.5030809@slaphack.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005, David Masover wrote:

> The point is, this was in the kernel for quite awhile, and it was so
> ugly that someone would rather be fucked with a chainsaw.  If something
> that bad can make it in the kernel and stay for awhile because it
> worked, and no one wanted to replace it

I would like to think we could learn from the mistakes
made in the past, instead of repeating them.

Ugly code often is so ugly people don't *want* to fix
it, so merging ugly code is often a big mistake.

-- 
The Theory of Escalating Commitment: "The cost of continuing mistakes is
borne by others, while the cost of admitting mistakes is borne by yourself."
  -- Joseph Stiglitz, Nobel Laureate in Economics
