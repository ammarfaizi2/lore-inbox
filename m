Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262023AbSLZDaZ>; Wed, 25 Dec 2002 22:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262040AbSLZDaY>; Wed, 25 Dec 2002 22:30:24 -0500
Received: from mail.econolodgetulsa.com ([198.78.66.163]:51218 "EHLO
	mail.econolodgetulsa.com") by vger.kernel.org with ESMTP
	id <S262023AbSLZDaX>; Wed, 25 Dec 2002 22:30:23 -0500
Date: Wed, 25 Dec 2002 19:38:35 -0800 (PST)
From: Josh Brooks <user@mail.econolodgetulsa.com>
To: Billy Rose <billyrose@billyrose.net>
cc: bp@dynastytech.com, <linux-kernel@vger.kernel.org>
Subject: Re: CPU failures ... or something else ?
In-Reply-To: <E18ROk3-000117-00@host.ehost4u.biz>
Message-ID: <20021225193618.X6873-100000@mail.econolodgetulsa.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well actually I ordered a complete replacement system - identical in every
way.  So I am getting that on saturday, and presumably that will just be
the big hammer that makes every problem go away.

I am just posting to get a head start on the issue if, for some crazy
reason I replace all hardware and the problem continues.  Sounds like that
is a slim to none chance, since I am dealing with good hardware (dell) and
it looks like this is a faulty component at work.

Basically I am just moving the disks from one machine to another on
saturday, and I suspect the problems just disappear when I do that.

Comments on the possibility that the problems continue after moving the
disks to different (but identical) hardware ?

thanks!

On Wed, 25 Dec 2002, Billy Rose wrote:

> > Oh and by the way, this is a dell poweredge 2450, dual 866 p3 cpus,
> > 2gigs ram, and using a PERC 3/D.  I have a 2.4.1 system running on
> > _identical_ hardware with no problems, and this system that is
> > MCE'ing is a 2.4.16.
>
> try reseating the cpu's and vrm's. if that doesnt work, remove cpu #2
> and #2 vrm. run it and see if the error occurs. if no error, #2 cpu or
> #2 vrm is bad. if the error still occurs, swap out cpu #1 and #1 vrm
> with cpu #2 and #2 vrm, then run again. if the error still occurs,
> youre SOL.
>
> billy
>
> =====
> "there's some milk in the fridge that's about to go bad...
> and there it goes..." -bobby
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

