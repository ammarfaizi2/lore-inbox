Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTEXWDf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 18:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbTEXWDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 18:03:35 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:11782 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261188AbTEXWDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 18:03:35 -0400
Date: Sun, 25 May 2003 00:16:42 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make vt_ioctl ix86isms explicit
Message-ID: <20030525001642.A1537@pclin040.win.tue.nl>
References: <20030524173713.GA4939@lst.de> <Pine.LNX.4.44.0305241046590.10806-100000@home.transmeta.com> <20030524180317.GA5383@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030524180317.GA5383@lst.de>; from hch@lst.de on Sat, May 24, 2003 at 08:03:17PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 24, 2003 at 08:03:17PM +0200, Christoph Hellwig wrote:

> What about this one instead?  If no one sees this messages we can just
> rip it out in 2.7.<early>

I think you can just rip it out.

A grep on some random source tree shows zero occurrences.
XFree86 uses it only in DGUX and SYSV sections.
A larger search turns up one more small program dated 1990.

Andries

