Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbVJ2Ajj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbVJ2Ajj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 20:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbVJ2Aji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 20:39:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16347 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750946AbVJ2Aji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 20:39:38 -0400
Date: Fri, 28 Oct 2005 17:39:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [git pull] InfiniBand updates for 2.6.14
Message-Id: <20051028173901.6bd2c302.akpm@osdl.org>
In-Reply-To: <52y84dp44d.fsf@cisco.com>
References: <523bmlqkg0.fsf@cisco.com>
	<20051028171218.2b8e71e7.akpm@osdl.org>
	<52y84dp44d.fsf@cisco.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <rolandd@cisco.com> wrote:
>
>     Andrew> a) arrange for the current infiniband devel tree to be
>     Andrew> included in -mm and
> 
> Sure.  How do you want to handle that?  The way I've been working
> lately is to merge things onto my "upstream" branch when I intend for
> them to go to Linus eventually, and merge that onto the "for-linus"
> branch when I'm going to ask Linus to pull.  I guess it would make
> sense for you to grab the upstream branch for -mm.

That suits.  I'll include

master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git#upstream
	
>     Andrew> b) arrange for infiniband patches to get wider review than this?
> 
> No objection from me.  How do you suggest I do that?  Post things to
> linux-kernel as I merge them into git?

That would be suitable, I guess.  It's a bit of a hassle, but some bugs
will likely be found, and useful suggestions will be made.
