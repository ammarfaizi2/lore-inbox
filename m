Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129610AbRAJWDo>; Wed, 10 Jan 2001 17:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131022AbRAJWDe>; Wed, 10 Jan 2001 17:03:34 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:54794 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S129610AbRAJWDa>;
	Wed, 10 Jan 2001 17:03:30 -0500
Date: Wed, 10 Jan 2001 23:03:54 +0100 (CET)
From: <kernel@ddx.a2000.nu>
To: Hacksaw <hacksaw@hacksaw.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: unexplained high load 
In-Reply-To: <200101102157.f0ALvCr01485@habitrail.home.fools-errant.com>
Message-ID: <Pine.LNX.4.30.0101102258290.4377-100000@ddx.a2000.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Jan 2001, Hacksaw wrote:

> > .nfs0000000000ca402500000006
> >
> > so i think there is some lock from the nfs server or client
> >
> > will try to restart nfs client
> > and see if this fixes it.
> >
>
> Most likely you will have to restart the nfs server on the other side as well,
> but it's worth a try.
tried it, didn't fix it
so i'll have to upgrade kernel and reboot
will do this this weekend, think the box can survive a few days (it has
112 days uptime now)

>
> Tripwire watches the checksum of the binaries you deem important, and
> complains if they change. There are a few things like it.
ah ok
have heard about it yeah

>
> See http://freshmeat.net/search/?q=tripwire
>
>
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
