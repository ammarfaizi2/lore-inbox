Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbVK0OfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbVK0OfG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 09:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbVK0OfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 09:35:06 -0500
Received: from mail.yosifov.net ([193.200.14.114]:26589 "EHLO home.yosifov.net")
	by vger.kernel.org with ESMTP id S1751080AbVK0OfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 09:35:04 -0500
Subject: Re: PC speaker beeping on high CPU loads on an nForce2
From: Ivan Yosifov <ivan@yosifov.net>
Reply-To: ivan@yosifov.net
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Martin Drab <drab@kepler.fjfi.cvut.cz>
In-Reply-To: <200511270111.29831.gene.heskett@verizon.net>
References: <Pine.LNX.4.60.0511270409430.30055@kepler.fjfi.cvut.cz>
	 <200511270111.29831.gene.heskett@verizon.net>
Content-Type: text/plain
Date: Sun, 27 Nov 2005 16:34:26 +0200
Message-Id: <1133102066.2769.3.camel@home.yosifov.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-11-27 at 01:11 -0500, Gene Heskett wrote:
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
> heat
> sink fins.

Gee ! The timeframe is just 3 months here... :-/

> 
> If its been doing it for a while, I expect the grease between the
> bottom of the heat sink and the top pf the cpu has also dried out and
> is no longer as effective at moving the heat from the cpu into the
> heat sink itself.  So its probably a good idea to do a shut down,
> remove the heat sink/fan combo, clean it all up and put a dab of new
> grease under the heat sink before ytou clip it back on.  I'm partial
> to a fancy bit of stuff called artic silver, which when fresh, is
> pretty darned good at moving the heat.
> 
> If you aren't comfortable doing all that, find someone who is.
> 

