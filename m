Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbUDXUEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbUDXUEN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 16:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbUDXUEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 16:04:13 -0400
Received: from pop.gmx.net ([213.165.64.20]:43448 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261752AbUDXUEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 16:04:07 -0400
X-Authenticated: #20450766
Date: Sat, 24 Apr 2004 22:00:10 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
cc: Guennadi Liakhovetski <gl@dsa-ac.de>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [somewhat OT] binary modules agaaaain
In-Reply-To: <408A3B82.5020807@softhome.net>
Message-ID: <Pine.LNX.4.44.0404242146100.1890-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Apr 2004, Ihar 'Philips' Filipau wrote:

> Guennadi Liakhovetski wrote:
> > Hello all
> >
> > I came across an idea, how Linux could allow binary modules, still having
> > reasonable control over them.
> >
> > I am not advocating for binary modules, nor I am trying to make their life
> > harder, this is just an idea how it could be done.
> >
> > I'll try to make it short, details may be discussed later, if any interest
> > arises.
> >
> > A binary module is "considered good" if
>
>    I belive that you forgot to make "The Point."

May be...

>    And "discussion" (good vs. bad isn't discussion, but flames) went in
> wrong direction.

Very right. Let me try to explain it again. It was just an idea, that
popped in my mind. I was not sure if it was good or bad, so, I decided to
dump it to lkml, so, that the people here could evaluate it. And, if it
can be of any use - use it. I, personally, don't care much (at least at
the moment) about binary drivers. And I most of all wanted to avoid
starting a new wave of flames. That's why I tried to avoid answering to
other posters (sorry, if it was somewhat impolite).

>    Be constructive. For example: Let's aks h/w producers making at least
> glue layer open source (bsd or something), so people eventually might
> help to maintain this glue layer.
>    How it can help? - producer with time may move bigger parts of driver
> into open source domains.
>    How it can gets screwed? - producer might just start liking when
> someone is doing his work for him. Some license a-la GPL to not let glue
> layer to slip into binary only domain back must be in place.
>
>    This could be a good starting point for h/w producers and linux
> comunity as a whole.
>
>    Saying Good/Bad is just B.S. - helps no-one.
>    Building bridges between comunity and producers - might improve and
> deepen relationships. And that's what I hope for.

Thanks! You seem to have understood the idea pretty close to what I mean,
and, probably, you are better capable of explaining things, than I:-) But,
I think, if it is going to be discussed further, let's move it away from
LKML (you are right, Bart). It can either be discussed in private emails,
or, maybe someone could create a dedicated mailing list somewhere.

Thanks
Guennadi
---
Guennadi Liakhovetski


