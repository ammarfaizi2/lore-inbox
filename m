Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262732AbUDAGsJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 01:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbUDAGsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 01:48:09 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:46209 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S262732AbUDAGsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 01:48:05 -0500
Date: Thu, 1 Apr 2004 08:48:06 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: who is merlin.fit.vutbr.cz?
Message-ID: <20040401064806.GA445@ucw.cz>
References: <200403290108.i2T18T8d024595@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403290108.i2T18T8d024595@work.bitmover.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2004 at 05:08:29PM -0800, Larry McVoy wrote:

> Folks, I need your help.
> 
> I can't tell if this is a DOS attack or someone with a REALLY slow net
> connection.  Whoever this is has been cloning the linux 2.6 (aka 2.5)
> tree on bkbits so slowly that the tree is locked for days and can't
> be updated.  About once a day I go kill the clone because stracing it
> shows it doing nothing.

[snip]

> Anyway, we've suffered more than enough bad press so before I
> assume that this host is a rogue and filter them, does anyone know who
> merlin.fit.vutbr.cz is?  If they really have that slow of a connection
> we'll burn a CD and Fedex it to them, nobody should suffer that much.
> But if this is just a DOS, we'll nuke 'em.

.cz: 	Czech Republic
.vutbr:	Technical University of Brno
.fit:	Faculty of Information Technology
merlin:	a Linux server serving home directories and login accounts to
        students

So it's likely a student doing the 'bk clone'.

What's surprising is that merlin shouldn't have a slow network
connection - quite the opposite - it's near the academic backbone of the
Czech Republic (a 2.5 gbit/sec pipe).

But maybe something doesn't work correctly - some NAT or MTU problem
stopping the communication ...

Or it's indeed an evil student.

The administrative contact for that machine is linux@fit.vutbr.cz.

I hope this helps.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
