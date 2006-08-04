Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbWHDFa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbWHDFa4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbWHDFa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:30:56 -0400
Received: from brick.kernel.dk ([62.242.22.158]:4115 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1030261AbWHDFaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:30:55 -0400
Date: Fri, 4 Aug 2006 07:31:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Nate Diller <nate.diller@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: SPAM: Re: [PATCH -mm] [3/3] Add the Elevator I/O scheduler
Message-ID: <20060804053136.GC4717@suse.de>
References: <5c49b0ed0608031921o7f140a80g3c4f860e9890186e@mail.gmail.com> <20060803221727.acf4197d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060803221727.acf4197d.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03 2006, Andrew Morton wrote:
> On Thu, 3 Aug 2006 19:21:45 -0700
> "Nate Diller" <nate.diller@gmail.com> wrote:
> 
> > This is the Elevator I/O scheduler.
> 
> I stuck this in -mm (after fixing many tens of wordwrapping corruptions).
> 
> It does need many coding style fixes sometime.  80-cols, newlines after
> `if' statements, macros->commented-inlines, fix a=b=c=d=e=<expr> statements,
> etc.  Well-understood stuff.  So we'll need a version 2 sometime, please.  
> 
> Meanwhile, what we have here is OK for people to review-n-test.

Can you please lets this go through the block branch, it needs to be
rebased against that anyway.

-- 
Jens Axboe

