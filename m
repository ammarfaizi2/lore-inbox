Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318420AbSGaRyf>; Wed, 31 Jul 2002 13:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318419AbSGaRyf>; Wed, 31 Jul 2002 13:54:35 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:2830 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318420AbSGaRye>; Wed, 31 Jul 2002 13:54:34 -0400
Date: Wed, 31 Jul 2002 13:50:05 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Martin Mares <mj@ucw.cz>
cc: Dave Jones <davej@suse.de>, Russell King <rmk@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: /proc/pci removal?
In-Reply-To: <20020729162301.GA5377@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.3.96.1020731134349.10066B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2002, Martin Mares wrote:

> Hello, world!\n
> 
> > ISTR Linus was quite attached to it, so it got un-obsoleted.
> 
> Exactly.  I've marked it as obsolete years ago, but when I wanted
> to rip it out, Linus said he likes /proc/pci and it has to stay.
> 
> I still think that it's an extremely ugly interface, especially
> because it requires the kernel to contain the list of vendor and device
> names.

If for no other reason than allowing easy updates, this would be a good
place for a module. Of course you can say that about the blacklisted
chipsets, etc, as well.

I guess if it's a favorite feature it stays. I do use it, but there are
other tools as mentioned.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

