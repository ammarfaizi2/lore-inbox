Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131365AbRCWTaL>; Fri, 23 Mar 2001 14:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131368AbRCWTaC>; Fri, 23 Mar 2001 14:30:02 -0500
Received: from relay03.cablecom.net ([62.2.33.103]:44806 "EHLO
	relay03.cablecom.net") by vger.kernel.org with ESMTP
	id <S131365AbRCWT3x>; Fri, 23 Mar 2001 14:29:53 -0500
Message-ID: <3ABBA400.2AEC97E8@bluewin.ch>
Date: Fri, 23 Mar 2001 20:29:03 +0100
From: Otto Wyss <otto.wyss@bluewin.ch>
Reply-To: otto.wyss@bluewin.ch
X-Mailer: Mozilla 4.76 (Macintosh; U; PPC)
X-Accept-Language: de,en
MIME-Version: 1.0
To: David Balazic <david.balazic@uni-mb.si>, linux-kernel@vger.kernel.org
Subject: Re: Linux should better cope with power failure
In-Reply-To: <3ABB6B82.62293CAD@uni-mb.si>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I had a similar experience:
> X crashed , hosing the console , so I could not initiate
> a proper shutdown.
> 
> Here I must note that the response you got on linux-kernel is
> shameful.
> 
Thanks, but I expected it a little bit. All around Linux is centered
around getting the highest performance out of it and very low (to low
IMHO) is done to have a save system. The attitude "It doesn't matter
making mistakes, they get fix anyhow" annoys me most, especially if it
were easy to prevent them. 

> What I did was to write a kernel/apmd patch , that performed a
> proper shutdown when I press the power button ( which luckily
> works as long as the kernel works ).
> 
Not with a AT power supply but certainly nice to have. See that it gets
included into the kernel. I didn't lost anything important since it was
just a testing machine. I was just shocked what fsck complained on a
machine which hadn't done almost anything at all. If I'd run into this
on a productive system I'd get immediately a serial keyboard or have at
least a usable network connection. Besides USB-only is not ready yet.

> > Don't we tell children never go close to any abyss or doesn't have
> > alpinist a saying "never go to the limits"? So why is this simple rule
> > always broken with computers?
> >
Is there a similar expression which could be hammered into any
developers mind, i.e. "Don't make errors, others already do them for you".

O. Wyss
