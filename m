Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265939AbUBPXIl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 18:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265924AbUBPXI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 18:08:27 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:64525 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265975AbUBPXHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 18:07:16 -0500
Date: Mon, 16 Feb 2004 23:07:12 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] back out fbdev sysfs support
In-Reply-To: <1076972292.3648.83.camel@gaston>
Message-ID: <Pine.LNX.4.44.0402162306250.21833-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > James: The fbcon & cursor changes must get in asap. There are races that
> > > I fixed, without the changes, those races will be in 2.6.3.
> > 
> > I just sent out a patch for people to try and look over before I submit 
> > it.
> 
> Double check with what I already commited.

It against Linus latest tree which included your submitted changes.



