Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbUKOLZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbUKOLZE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 06:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbUKOLZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 06:25:03 -0500
Received: from host-212-158-219-180.bulldogdsl.com ([212.158.219.180]:35222
	"EHLO aeryn.fluff.org.uk") by vger.kernel.org with ESMTP
	id S261567AbUKOLYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 06:24:39 -0500
Date: Mon, 15 Nov 2004 11:24:38 +0000
From: Ben Dooks <ben-linux@fluff.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-rc2
Message-ID: <20041115112438.GC17957@home.fluff.org>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org> <20041115102620.A25762@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041115102620.A25762@flint.arm.linux.org.uk>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 10:26:20AM +0000, Russell King wrote:
> On Sun, Nov 14, 2004 at 06:49:04PM -0800, Linus Torvalds wrote:
> > Ok, the -rc2 changes are almost as big as the -rc1 changes, and we should 
> > now calm down, so I do not want to see anything but bug-fixes until 2.6.10 
> > is released. Otherwise we'll never get there.
> 
> There's a few more non-bugfix changes which need merging first though.
> Namely an update to the S3C2410 serial driver from Ben to allow the
> s3c2410 changes which are now in 2.6.10-rc2 to work.  Otherwise I
> suspect s3c2410 is going to be dead in the water for 2.6.10.

The new patch for the serial driver fixes/updates has been sent to
rmk, so hopefully this should complete the patch set.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
