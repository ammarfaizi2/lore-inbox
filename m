Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318825AbSG0Vhd>; Sat, 27 Jul 2002 17:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318831AbSG0Vhc>; Sat, 27 Jul 2002 17:37:32 -0400
Received: from pcp01179415pcs.strl1201.mi.comcast.net ([68.60.208.36]:8432
	"EHLO mythical") by vger.kernel.org with ESMTP id <S318825AbSG0Vhc>;
	Sat, 27 Jul 2002 17:37:32 -0400
Date: Sat, 27 Jul 2002 17:40:12 -0400 (EDT)
From: Ryan Anderson <ryan@michonline.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
       "David D. Hagood" <wowbagger@sktc.net>,
       Andrew Rodland <arodland@noln.com>, linux-kernel@vger.kernel.org
Subject: Re: Speaker twiddling [was: Re: Panicking in morse code]
In-Reply-To: <1027809643.21511.0.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10207271735000.579-100000@mythical.michonline.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Morse doesn't do "<" and other common characters. For those
> > who know it, morse is useful. For well over 99% of the users,
> > morse is gibberish anyway.
> 
> I spent a long time suffering to learn morse. Now for once in my life
> it'll actually be -useful-

I suspect that the speaker twiddling portion of the code is 100 times
more important than the LED blinking part of it.  Everyone I know (as a
Radio Amateur) that knows Morse learned it by hearing it - seeing
blinking lights is a totally different part of the brain that needs to
learn how to interpret the input.

My gut feeling says that this patch falls into the "cool hack" category,
more than anything else - but the best part about cool hacks is that
they are occassionally really really useful to someone.

--
Ryan Anderson
  sometimes Pug Majere


