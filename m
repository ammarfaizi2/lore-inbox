Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129872AbQKWUrP>; Thu, 23 Nov 2000 15:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129857AbQKWUqz>; Thu, 23 Nov 2000 15:46:55 -0500
Received: from taku.hut.fi ([130.233.228.87]:17683 "EHLO taku.hut.fi")
        by vger.kernel.org with ESMTP id <S129586AbQKWUqx>;
        Thu, 23 Nov 2000 15:46:53 -0500
Date: Thu, 23 Nov 2000 22:16:40 +0200 (EET)
From: Tuomas Heino <iheino@cc.hut.fi>
To: Charles Cazabon <linux@discworld.dyndns.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: silly [< >] and other excess
In-Reply-To: <20001123082904.B1485@qcc.sk.ca>
Message-ID: <Pine.OSF.4.10.10011232209330.16635-100000@smaragdi.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2000, Charles Cazabon wrote:

> Andries.Brouwer@cwi.nl <Andries.Brouwer@cwi.nl> wrote:

> > > Thats because too many things get put on a line then.
> > > And because we do [<foo>] [<bar>]  not   [<foo>][<bar>] ?
> > 
> > In the good old times we had  foo bar  for a total of 8*(8+1) = 72
> > positions. Now we have [<foo>] [<bar>] which takes 8*(8+1+4) = 104
> > positions. If you turned this into 6 items per line instead of 8,
> > it would certainly improve matters a bit.
> 
> The original poster complained the output lines were too wide for the screen
> on his PC.  Perhaps he should change his console mode to 132 characters wide
> (via SVGATextMode or such) -- voila, no more problem, no broken kernel patches.

Well that 72 characters is also known as the "safe" email line length...
... and besides some people still use the old VT330s and alike ;)

But in practice even those 79 chars would be better than 104.

--
No .sig here... especially no 128x48 .sig here - nor 132xYuch...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
