Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130565AbRBRAwL>; Sat, 17 Feb 2001 19:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132127AbRBRAwB>; Sat, 17 Feb 2001 19:52:01 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:63243 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130565AbRBRAvo>; Sat, 17 Feb 2001 19:51:44 -0500
Date: Sat, 17 Feb 2001 18:51:37 -0600
To: Dennis <dennis@etinc.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux stifles innovation...
Message-ID: <20010217185137.C28785@cadcamlab.org>
In-Reply-To: <3A8CF1FE.16672.10105D@localhost> <3A8CF1FE.16672.10105D@localhost> <01021613494900.00295@tabby> <5.0.0.25.0.20010216170349.01efc030@mail.etinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <5.0.0.25.0.20010216170349.01efc030@mail.etinc.com>; from dennis@etinc.com on Fri, Feb 16, 2001 at 05:27:31PM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Dennis]
> For example, if there were six different companies that marketed
> ethernet drivers for the eepro100, you'd have a choice of which one
> to buy..perhaps with different "features" that were of value to
> you. Instead, you have crappy GPL code that locks up under load, and
> its not worth spending corporate dollars to fix it because you have
> to give away your work for free under GPL. And since there is a
> "free" driver that most people can use, its not worth building a
> better mousetrap either because the market is too small. So, the
> handful of users with problems get to "fit it themselves", most of
> whom cant of course.

You may have a point but device drivers are a piss-poor example.  Say
Linux does take over the world, and eepro100 continues to lock up under
load.  Who loses?  Intel.  People will quit buying their motherboards
and PCI cards.  So for whom is it worth spending corporate dollars
fixing eepro100?  Again, Intel.  If word were to get out "avoid Intel
network cards, the driver is crap", you can bet they will fix it.

If this hasn't happened yet, it's because Intel doesn't see enough
market in Linux to bother.  And if so, so what?  There are plenty of
motherboards with pcnet32 and 3c9xx chips.

Peter
