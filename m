Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265951AbUBPWrC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 17:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265953AbUBPWrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 17:47:01 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:47629 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265951AbUBPWo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 17:44:58 -0500
Date: Mon, 16 Feb 2004 22:44:54 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Christoph Hellwig <hch@lst.de>
cc: torvalds@osdl.org, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] back out fbdev sysfs support
In-Reply-To: <20040214165037.GA15985@lst.de>
Message-ID: <Pine.LNX.4.44.0402162243220.21833-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> <rant>
> James, what about pushing the 2GB worth of fbdev driver fixes in your
> tree to Linus so people actually get working fb support again instead
> of adding new holes?  A maintainers job can't be to apply patches to
> his personal CVS repository and sitting on them forever
> </rant>

I don't have 2GB of patches. I have way less than that. Almost every core 
change is in now. I'm very cautious and I rather have drivers tested for a 
long time. 

