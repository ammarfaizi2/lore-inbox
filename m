Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbVIPUxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbVIPUxZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 16:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbVIPUxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 16:53:24 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:19685 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751284AbVIPUxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 16:53:24 -0400
Date: Fri, 16 Sep 2005 16:53:23 -0400
To: Hans Reiser <reiser@namesys.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Message-ID: <20050916205323.GJ28578@csclub.uwaterloo.ca>
References: <432AFB44.9060707@namesys.com> <20050916174028.GA32745@infradead.org> <432B1F84.3000902@namesys.com> <20050916205045.GI28578@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050916205045.GI28578@csclub.uwaterloo.ca>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 04:50:45PM -0400, Lennart Sorensen wrote:
> Well my experience with XFS for about 6 months using 2.6 kernels has
> been about as good as my experience with reiserfs 3.6 back when 2.4
> was fairly new.
> 
> That's why I run ext3.
> 
> I don't need my filesystem locking up, leaking memory all over the
> place, causing processes to be killed byt the out of memory handler,
> etc.  I will stick with what works all the time.
> 
> Performance and nifty features are fun, but only when they don't break
> your system.

In other words that means: Neither was ready for use when they were
included in the kernel and should probably have had big warning signs in
the kernel config for them.  They also seem sufficiently complex that
fixing them is very hard work.

Len Sorensen
