Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262671AbUKBXWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbUKBXWk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 18:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbUKBXWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 18:22:23 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1295 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262706AbUKBXRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 18:17:08 -0500
Date: Tue, 2 Nov 2004 23:17:03 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Serial updates
Message-ID: <20041102231703.D10969@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, benh@kernel.crashing.org,
	linux-kernel@vger.kernel.org
References: <20041031175114.B17342@flint.arm.linux.org.uk> <1099368552.29693.434.camel@gaston> <1099369226.29689.441.camel@gaston> <20041102224329.B10969@flint.arm.linux.org.uk> <20041102150112.2ce4831f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041102150112.2ce4831f.akpm@osdl.org>; from akpm@osdl.org on Tue, Nov 02, 2004 at 03:01:12PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 03:01:12PM -0800, Andrew Morton wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> >
> > On Tue, Nov 02, 2004 at 03:20:26PM +1100, Benjamin Herrenschmidt wrote:
> > > And here's another one that also fixes a little bug in the
> > > default console selection code ...
> > 
> > Thanks for testing Ben, applied.
> > 
> > akpm - do you want this set of serial changes to appear in one -mm
> > release before hitting Linus?
> > 
> 
> Not really - there's plenty of time to shake out any problems.

Ok, I'll send a pull request imminently.  For those who don't want to
wait, latest patch against Linus' tree is at:

  http://www.arm.linux.org.uk/~rmk/misc/linus-serial.diff

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
