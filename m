Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbVH3NMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbVH3NMo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 09:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbVH3NMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 09:12:44 -0400
Received: from styx.suse.cz ([82.119.242.94]:12765 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751428AbVH3NMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 09:12:43 -0400
Date: Tue, 30 Aug 2005 15:12:56 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Harald Welte <laforge@gpl-violations.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: APs from the Kernel Summit run Linux
Message-ID: <20050830131256.GA12381@midnight.suse.cz>
References: <20050830085522.GA8820@midnight.suse.cz> <20050830101958.GJ4202@rama.de.gnumonks.org> <20050830121810.GA11582@midnight.suse.cz> <20050830125648.GG4295@rama.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050830125648.GG4295@rama.de.gnumonks.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 02:56:49PM +0200, Harald Welte wrote:

> > The device's ESSID during boot is 'Marvell AP-32', and the Libertas
> > AP-32 and AP-52 design toolkits contain only ports of Linux and eCos to
> > the device, according to Marvell. Considering the device's routing
> > capabilities I'm believe it's running Linux, but I don't have a solid
> > proof yet, unfortunately. The eCos port is intended for the non-router
> > variety of the design.
> 
> There could also be a 3rd party toolkit with a different OS that you
> don't know about...

It's definitely possible.

> > On the other hand, eCos seems to be GPL, too, although it's possible
> > that the owner dual-licenses it.
> 
> According to http://sources.redhat.com/ecos/, it is either still RedHat
> or already transferred to the FSF.  That doesn't sound like dual
> licensing, I don't think the FSF would do that...

That was my thinking, too.

> > > > A firmware image is available from D-Link
> > > > and it seems to be composed of compressed blocks padded by zeroes. I haven't
> > > > verified yet that it's indeed a compressed kernel, cramfs, etc, but it seems
> > > > quite likely.
> > > 
> > > I'm downloading it right now, and I'll see whether I can find any Linux
> > > in there.
> > 
> > Good luck. I'll try to take a look, too.
> 
> Up to now I can only tell you that it doesn't look like any of the 50+
> linux firmware images I've seen so far.

Too bad. Well, I'll have to try to hook up a serial port.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
