Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263557AbTJQRZU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 13:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263561AbTJQRZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 13:25:19 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:52492 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263557AbTJQRZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 13:25:14 -0400
Date: Fri, 17 Oct 2003 18:25:11 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] FBDEV 2.6.0-test7 updates.
In-Reply-To: <1066389516.4777.231.camel@gaston>
Message-ID: <Pine.LNX.4.44.0310171824190.966-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > drivers/video/radeonfb.c still exists, while the build system now uses the one
> > in drivers/video/aty?
> 
> I haven't checked what James did here. In my tree, I was careful to keep
> both old and new drivers available via 2 separate CONFIG options. 

The BK tree doesn't have the new radeon driver. I placed the new radeon 
driver into the patch so people coudl test it.


