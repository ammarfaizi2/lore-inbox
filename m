Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272661AbTHPJKx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 05:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272672AbTHPJKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 05:10:53 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:1497 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S272661AbTHPJKw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 05:10:52 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: George Anzinger <george@mvista.com>
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Date: Sat, 16 Aug 2003 05:10:44 -0400
User-Agent: KMail/1.5
Cc: LKML <linux-kernel@vger.kernel.org>
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200308132024.36967.rob@landley.net> <3F3B41C7.1000906@mvista.com>
In-Reply-To: <3F3B41C7.1000906@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308160510.44627.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 August 2003 04:01, George Anzinger wrote:

> >>Well said :)
> >
> > Actually, I didn't really consider that list of straw man arguments to be
> > worth commenting on the first time around.  (I thought he was being
> > sarcastic...)
>
> Well, I think he was too, but I am trying to say (as I think you are
> too) that it is not far from being a realistic goal.

2.5 already seems to be scheduling better for me, although I'm still mostly 
running 2.4 on my new laptop until I figure out how to properly configure all 
the new hardware.  (APM suspends, and then never comes back until you yank 
the #*%(&# battery.  Great.  Trying it with the real mode bios calls next 
reboot...)

> As to timing, I just changed ISPs and was off line for a few days...

I got caught in a downpour with my laptop in my backpack, and didn't realise 
the water resistant coating on my backpack had worn away until I turned the 
thing on and the display shorted out.  After two days of drying out, the 
display was still screwed up, so I just bought a used thinkpad (iseries 1300, 
quite a nice little machine) and swapped the hard drive and some ram from my 
old toshiba.  (Kudzu actually did something useful for once. :)

I think I've figured out why X is giving me an 800x600 window on a 1024x768 
display screen (with a big black border).  Why XFree86 freezes the box solid 
for ten seconds at a time while KDE is probing the hardware devices, that I 
don't know.  (Google suggests the USB is funky.  I'll see if 2.5 fixes it, 
all I know of 2.5 on this box is that it booted to text mode and then shut 
down again ok...)

I'm likely to be a bit distracted for a while yet, not counting catching up, 
being out of town for a weekend, and of course the fall semester starting in 
two weeks.  Luckily, they make caffeine for just such occasions...

Rob
