Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275280AbTHGKEk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 06:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275283AbTHGKEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 06:04:39 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:40632 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S275280AbTHGKEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 06:04:33 -0400
Date: Thu, 7 Aug 2003 12:04:19 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: cb-lkml@fish.zetnet.co.uk, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Disk priority dependend on nice level...
Message-ID: <20030807100419.GC166@elf.ucw.cz>
References: <20030806232810.GA1623@elf.ucw.cz> <20030806234036.GA209@elf.ucw.cz> <20030807080251.GY7982@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030807080251.GY7982@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I ported `subj` to 2.6.0-test2. I do not yet have idea if it works,
> > > but it compiles ;-).
> > 
> > It compiles, it event boots, but it does not seem to have much effect
> > :-(.
> 
> Now that the queue reference counting is in the current bk tree, we are
> that much closer to real modular io schedulers. I'll post the cfq with
> priorities for that.

I'm looking forward to that. (If you have some patch I could test,
mail it my way).
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
