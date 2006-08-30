Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751495AbWH3UVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbWH3UVw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 16:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWH3UVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 16:21:52 -0400
Received: from brick.kernel.dk ([62.242.22.158]:20743 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751495AbWH3UVv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 16:21:51 -0400
Date: Wed, 30 Aug 2006 22:24:41 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/19] BLOCK: Make it possible to disable the block  layer [try #6]
Message-ID: <20060830202440.GN7331@kernel.dk>
References: <20060829180552.32596.15290.stgit@warthog.cambridge.redhat.com> <20060829180634.32596.4507.stgit@warthog.cambridge.redhat.com> <20060830124400.23ca9b38.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060830124400.23ca9b38.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30 2006, Andrew Morton wrote:
> 
> I think I'll just slam all this in at the first opportunity.  Stuff will
> break, but it will be easy to fix.

I think so too, hence I added it to the for-akpm branch that you pull so
it should happen automagically for you.

-- 
Jens Axboe

