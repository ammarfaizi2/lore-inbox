Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267028AbSLXBfo>; Mon, 23 Dec 2002 20:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267030AbSLXBfo>; Mon, 23 Dec 2002 20:35:44 -0500
Received: from ns2.snowman.net ([66.93.83.121]:32524 "EHLO relay.snowman.net")
	by vger.kernel.org with ESMTP id <S267028AbSLXBfo>;
	Mon, 23 Dec 2002 20:35:44 -0500
From: nick@snowman.net
Date: Mon, 23 Dec 2002 20:43:51 -0500 (EST)
To: Jeff Garzik <jgarzik@pobox.com>
cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: OT: Which Gigabit ethernet card?
In-Reply-To: <20021223173514.GA19833@gtf.org>
Message-ID: <Pine.LNX.4.21.0212232043160.4046-100000@ns.snowman.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahh, thanks for the clarification.  I wasn't aware of it, however I'd seen
hints in a few spec sheets that now make much more sense.
	Thanks
		Nick

On Mon, 23 Dec 2002, Jeff Garzik wrote:

> On Mon, Dec 23, 2002 at 05:28:11PM +0000, Justin Cormack wrote:
> > er, no. GigE over copper autodetects crossovers, so a standard cable
> > will work anyway. Actually this has been backported to some 100MB
> > switches now (presumably use same io interfaces) so crossover cables are
> > fast disappearing. You can even stick a non crossover cable between a
> > 100MB pci card and a GigE one and it will work.
> 
> Yep.  This is called auto-polarity detection, FWIW.
> 

