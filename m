Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265956AbUBPWuo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 17:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265982AbUBPWun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 17:50:43 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:54285 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265956AbUBPWtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 17:49:13 -0500
Date: Mon, 16 Feb 2004 22:49:10 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] back out fbdev sysfs support
In-Reply-To: <1076799884.4199.37.camel@gaston>
Message-ID: <Pine.LNX.4.44.0402162248040.21833-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'll send you/andrew individually the drivers I control and the ones I
> already fixed in james tree (5 or 6 drivers)

I have drivers as well which I need to send. 
 
> James: The fbcon & cursor changes must get in asap. There are races that
> I fixed, without the changes, those races will be in 2.6.3.

I just sent out a patch for people to try and look over before I submit 
it.


