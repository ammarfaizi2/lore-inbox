Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbVADUkC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbVADUkC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 15:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbVADUjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 15:39:53 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:28941 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262155AbVADUjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 15:39:10 -0500
Date: Tue, 4 Jan 2005 21:30:33 +0100
From: Willy Tarreau <willy@w.ods.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Adrian Bunk <bunk@stusta.de>, Diego Calleja <diegocg@teleline.es>,
       davidsen@tmr.com, aebr@win.tue.nl, solt2@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050104203033.GC22075@alpha.home.local>
References: <20050103004551.GK4183@stusta.de> <20050103011935.GQ29332@holomorphy.com> <20050103053304.GA7048@alpha.home.local> <20050103142412.490239b8.diegocg@teleline.es> <20050103134727.GA2980@stusta.de> <20050104125738.GC2708@holomorphy.com> <20050104150810.GD3097@stusta.de> <20050104153445.GH2708@holomorphy.com> <20050104165301.GF3097@stusta.de> <20050104195725.GQ2708@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104195725.GQ2708@holomorphy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 11:57:25AM -0800, William Lee Irwin III wrote:
> On Tue, Jan 04, 2005 at 05:53:01PM +0100, Adrian Bunk wrote:
> > My opinion is to fork 2.7 pretty soon and to allow into 2.6 only the 
> > amount of changes that were allowed into 2.4 after 2.5 forked.
> > Looking at 2.4, this seems to be a promising model.
> 
> This must be considered relative to the size of the source code.
> Just because they're more changes than you can personally track does
> not mean they're large numbers of changes relative to the source's size.
> 
> Users' timidity in these regards should be taken as little more than
> a sign that the scale of the kernel's source is increasing, which is a
> good thing, as the kernel may then benefit from economies of scale.
> 
> The kernel's scale has long since increased beyond the point where an
> individual can effectively track its changes in realtime, and small
> matters of degree such as are being moaned about now are insubstantial.
> Similarly, counts of bugs and regressions should probably also be
> considered relative to the size of the kernel source.

William, I strongly agree with you regarding this (fortunately, it seems to
happen sometimes :-))

Speaking for myself, I read and try to understand *all* the changelog of 2.4
pre releases, and even often take a look at linux.bkbits.net to see if some
things have changed, that I could grab before waiting for a release, but I
almost never read 2.6 changelog (except the first hundreds of lines that Linus
announces with a final release), because it's far too much. I don't even know
how some people still keep in touch with this amount of changes.

Cheers,
Willy

