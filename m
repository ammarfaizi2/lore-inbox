Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbUBNR6P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 12:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbUBNR6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 12:58:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62639 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262603AbUBNR6O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 12:58:14 -0500
Date: Sat, 14 Feb 2004 17:58:13 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>, jsimmons@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] back out fbdev sysfs support
Message-ID: <20040214175813.GI8858@parcelfarce.linux.theplanet.co.uk>
References: <20040214165037.GA15985@lst.de> <Pine.LNX.4.58.0402140857520.13436@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402140857520.13436@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 14, 2004 at 09:02:12AM -0800, Linus Torvalds wrote:
> These things need to be done in a timely fashion, incrementally, one thing 
> at a time. Anything else does not work.
> 
> And btw, for anybody who is impacted by this: you are encouraged to help. 
> If you have a machine that works with some out-of-tree code but does 
> _not_ work with the in-tree code, send a patch that fixes JUST THAT BUG.
> 
> Because if James can't trickle them in, somebody else will have to. That's 
> what happened with the new radeon driver.

Where's James' repository, BTW?  I could help with split-and-reorder on
that one...
