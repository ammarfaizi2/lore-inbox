Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265965AbUBPXCI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 18:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266011AbUBPXBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 18:01:15 -0500
Received: from gate.crashing.org ([63.228.1.57]:41377 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265965AbUBPW6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 17:58:53 -0500
Subject: Re: [PATCH] back out fbdev sysfs support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0402162248040.21833-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0402162248040.21833-100000@phoenix.infradead.org>
Content-Type: text/plain
Message-Id: <1076972292.3648.83.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 17 Feb 2004 09:58:12 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-17 at 09:49, James Simmons wrote:
> > I'll send you/andrew individually the drivers I control and the ones I
> > already fixed in james tree (5 or 6 drivers)
> 
> I have drivers as well which I need to send. 
>  
> > James: The fbcon & cursor changes must get in asap. There are races that
> > I fixed, without the changes, those races will be in 2.6.3.
> 
> I just sent out a patch for people to try and look over before I submit 
> it.

Double check with what I already commited.

Ben.


