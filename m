Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbVK0R42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbVK0R42 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 12:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVK0R42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 12:56:28 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:62090 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP
	id S1751129AbVK0R42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 12:56:28 -0500
Date: Sun, 27 Nov 2005 18:56:23 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Gene Heskett <gene.heskett@verizon.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: PC speaker beeping on high CPU loads on an nForce2
In-Reply-To: <200511270111.29831.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.60.0511271839480.24919@kepler.fjfi.cvut.cz>
References: <Pine.LNX.4.60.0511270409430.30055@kepler.fjfi.cvut.cz>
 <200511270111.29831.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Nov 2005, Gene Heskett wrote:

> On Saturday 26 November 2005 22:23, Martin Drab wrote:
> >Hi,
> >
> >on an nForce2 system (GigaByte 7NNXP) when the CPU is under heavy load
> >(like during kernel compilation for instance, or any compilation of any
> >bigger project, for that matter), I hear some beeps comming out of the
> > PC speaker. It's like few short beeps per second for a while, then
> > silence for few seconds, then a beep here and there, and again, and so
> > on. It is quite strange. It happens ever since I remember (I mean in
> > kernel versions of course, I have the board for about 1.5 years). I've
> > just been kind of ignoring it until now. Does anybody else happen to
> > see the same symptoms? What could be the cause of this. Is it
> > something about timing? But how come the PC speaker gets kiced in,
> > while it's not being used at all (well, at least not intentionally)
> > for anything. Perhaps something is writing some ports it is not
> > supposed to?
> >
> >Martin
> 
> Usually, thats a sign of cpu overheating.  At 18 months, if the cpu
> fan/heat sink hasn't been blown out by an air hose, its so packed full
> of dust bunnies that no amount of rpms can force any air thru the cpu's 
> heat sink fins.

No, it isn't a problem of dust or grease. It is a problem of a case full 
of devices and bad airflow within it. (There's 6 HDDs, 8 PCI cards, an 
AthlonXP 3200+ with massive Zalman CNPS6000-Cu on top of it and 10 fans 
that are doing all they can running at maximum (with the noise of a 
medium vacuum cleaner ;), trying to cool it all, but it just isn't 
enough.) So I'll try to solve it by a water cooling.

I just didn't connect these sounds with the MB alarm. (Even though I know 
that there is this kind of feature.)

However thanks for the advises anyway,
Martin
