Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281927AbRKZRIA>; Mon, 26 Nov 2001 12:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281929AbRKZRHu>; Mon, 26 Nov 2001 12:07:50 -0500
Received: from lightning.hereintown.net ([207.196.96.3]:27334 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S281927AbRKZRHd>; Mon, 26 Nov 2001 12:07:33 -0500
Date: Mon, 26 Nov 2001 12:22:47 -0500 (EST)
From: Chris Meadors <clubneon@hereintown.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: David Relson <relson@osagesoftware.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Release Policy [was: Linux 2.4.16  ]
In-Reply-To: <Pine.LNX.4.21.0111261328450.13681-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.40.0111261216500.88-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001, Marcelo Tosatti wrote:

> Sorry for not being able to discuss this issues... Its just that I'm too
> busy doing the maintenance and other stuff at Conectiva at the same time
> (people are flooding me with patches, btw, please stop for a while).
>
> Daniel Quinlan suggested me to release a "pre-final" release before the
> real final one (which would catch most "stupid" bugs), and I think thats a
> nice way of solving the problem.
>
> I'll _probably_ do that --- not sure yet, though.

Aren't all the -pre's pre-finals?  And what if there is a big bug found in
the -final, it will obviously be followed up with a -final-final?

I like the ISC's release methods.  The do -rc's (-pre's would be fine for
the kernel as it is already established), each -rc fixes problems found
with the previous.  When an -rc has been out long enough with no more bug
reports they release that code, WITHOUT changes.

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

