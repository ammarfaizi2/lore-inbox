Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265624AbTIDWVc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 18:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265622AbTIDWVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 18:21:32 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:10381 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S265624AbTIDWUq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 18:20:46 -0400
Date: Thu, 4 Sep 2003 23:20:36 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Larry McVoy <lm@work.bitmover.com>,
       "Paul J.Y. Lahaie" <pjlahaie@steamballoon.com>,
       linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030904222036.GL31590@mail.jlokier.co.uk>
References: <20030901165239.GB3556@mail.jlokier.co.uk> <20030901181148.C22682@flint.arm.linux.org.uk> <20030902053415.GA7619@mail.jlokier.co.uk> <20030902091553.A29984@flint.arm.linux.org.uk> <20030902115731.GA14354@mail.jlokier.co.uk> <20030902195222.D9345@flint.arm.linux.org.uk> <20030902235900.GA5769@work.bitmover.com> <20030903083118.A17670@flint.arm.linux.org.uk> <20030903074134.GB19920@mail.jlokier.co.uk> <20030903190519.D24951@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903190519.D24951@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> > Larry means that it's perfectly normal for libc to map the same file
> > more than once: you have the code section and the data section.
> 
> Code is read-only, data is read-write and is copy on write.  Therefore
> its a different scenario.

Yes, a thinko on my part :)

-- Jamie
