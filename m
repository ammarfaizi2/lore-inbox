Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135711AbRAJVsD>; Wed, 10 Jan 2001 16:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129610AbRAJVrx>; Wed, 10 Jan 2001 16:47:53 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:40202 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S136655AbRAJVrm>;
	Wed, 10 Jan 2001 16:47:42 -0500
Date: Wed, 10 Jan 2001 22:47:35 +0100 (CET)
From: <kernel@ddx.a2000.nu>
To: Hacksaw <hacksaw@hacksaw.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: unexplained high load 
In-Reply-To: <200101102127.f0ALRSr01062@habitrail.home.fools-errant.com>
Message-ID: <Pine.LNX.4.30.0101102242440.4377-100000@ddx.a2000.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2001, Hacksaw wrote:

> >don't think
> >w,uptime,top give the same value
>
> The fact that they all give the same value does not indicate that you have not
> been cracked. Obviously, part of the hacking is to cover trails; it'd be a
> pretty poor job if they reported different values.
i also checked the files, they are not replaced last few months

>
> The mm stuff from your other message is, I think, an indication that you might
> be being hit by a memory management bug that was corrected in 2.2.19pre2.
>
> It is my sincere belief that you will need to upgrade your kernel, but
> you are in no serious danger.
ok so i'll have to upgrade
2.2.19pre7 is the latest i saw, is this one running stable ?
or should i better wait some time
(the 1.00 load doesn't really botter me, if i don't get any other errors
because of this bug)


>
> If it's a firewall box, you should be running tripwire or some free variation,
> to help eliminate the possibility that cracking would go undetected.
it's my homebox, connected to a cable modem
so it's not mission critical

what exactly is that tripwire you talk about ?
(never heard of it)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
