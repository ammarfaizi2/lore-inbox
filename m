Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132407AbRCZKUC>; Mon, 26 Mar 2001 05:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132408AbRCZKTw>; Mon, 26 Mar 2001 05:19:52 -0500
Received: from zeus.kernel.org ([209.10.41.242]:61640 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132407AbRCZKTn>;
	Mon, 26 Mar 2001 05:19:43 -0500
Date: Mon, 26 Mar 2001 12:17:39 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: Linux should better cope with power failure
To: otto.wyss@bluewin.ch
Cc: linux-kernel@vger.kernel.org
Message-id: <3ABF1743.76FCB096@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.7 [en] (WinNT; U)
Content-type: text/plain; charset=iso-8859-2
Content-transfer-encoding: 7bit
X-Accept-Language: en
In-Reply-To: <3ABB6B82.62293CAD@uni-mb.si> <3ABBA400.2AEC97E8@bluewin.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Otto Wyss wrote:
> 
> > I had a similar experience:
> > X crashed , hosing the console , so I could not initiate
> > a proper shutdown.
> >
> > Here I must note that the response you got on linux-kernel is
> > shameful.
> >
> Thanks, but I expected it a little bit. All around Linux is centered
> around getting the highest performance out of it and very low (to low
> IMHO) is done to have a save system. The attitude "It doesn't matter
> making mistakes, they get fix anyhow" annoys me most, especially if it
> were easy to prevent them.
> 
> > What I did was to write a kernel/apmd patch , that performed a
> > proper shutdown when I press the power button ( which luckily
> > works as long as the kernel works ).
> >
> Not with a AT power supply but certainly nice to have. See that it gets
> included into the kernel.

It was just a line or two bugfix, not a real patch. I will dig it up
and send a patch for 2.4 
When I have the time :-)


-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
