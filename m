Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264248AbTFPUQC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 16:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264252AbTFPUQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 16:16:02 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:51209 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264248AbTFPUP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 16:15:59 -0400
Date: Mon, 16 Jun 2003 21:29:51 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Torrey Hoffman <thoffman@arnor.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] 2.5.70-bk15: RadeonFB dies at boot, and is undocumented
In-Reply-To: <1055546532.1256.19.camel@torrey.et.myrio.com>
Message-ID: <Pine.LNX.4.44.0306140031430.29353-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> With the Radeon framebuffer driver compiled in, 2.5.70-bk15 oopses very
> early during the boot process.  The oops is visible in text mode but
> scrolls off the screen.  (I really need to set up a serial console!)

If you see the oops that is good thing. That means the framebuffer driver 
works. 

> [thoffman@torrey fb]$ pwd
> /home/archive/Kernels/linux-2.5.70-bk15/Documentation/fb
> [thoffman@torrey fb]$ grep radeon *
> [thoffman@torrey fb]$ 
> 
> There is not a single mention of the radeon driver under Documentation! 
> Even a 20 line note explaining what the kernel command line format is
> would be nice.

No :-( 

> PS: Mr. Simmons, I really appreciate your work on the framebuffer and
> console subsystem.  To make it easier for people to find you, perhaps a
> little patch to update your email addresses throughout the code would be
> worth while?   A quick grep under drivers/video turns up four different
> addresses in about a dozen files, hopefully I am sending this email to a
> current address:
> 
> jsimmons@users.sf.net
> jsimmons@linux-fbdev.org
> jsimmons@infradead.org
> jsimmons@transvirtual.com

Good point. I will update everything.


