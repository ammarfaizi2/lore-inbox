Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263505AbTH3KpH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 06:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263514AbTH3KpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 06:45:07 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:3037 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S263505AbTH3KpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 06:45:04 -0400
Date: Sat, 30 Aug 2003 12:35:23 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@muc.de>, Greg Stark <gsstark@mit.edu>,
       Martin Pool <mbp@sourcefrog.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: KDB in the mainstream 2.4.x kernels?
Message-ID: <20030830103523.GA386@elf.ucw.cz>
References: <aJIn.3mj.15@gated-at.bofh.it> <m3smp3y38y.fsf@averell.firstfloor.org> <pan.2003.08.13.04.40.27.59654@sourcefrog.net> <20030813110453.GA26019@colin2.muc.de> <87y8xiexue.fsf@stark.dyndns.tv> <20030825162303.GA7288@averell> <1061992194.22739.18.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061992194.22739.18.camel@dhcp23.swansea.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > instructions as a forth program that frobbed registers appropriately. The
> > > kernel would have a small forth interpretor to run it. Then switching
> > > resolutions could happen safely in the kernel.
> > 
> > Did the proposal come with working code?
> 
> I've seen workable non forth versions of the proposal yes. It isnt 
> actually that hard to do for most video cards 

We could make them use code for ACPI interpretter, that's already in
and has advantage that graphics people might eventually ship it in
card roms....
								Pavel


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
