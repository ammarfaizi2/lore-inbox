Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAPDoT>; Mon, 15 Jan 2001 22:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129747AbRAPDoJ>; Mon, 15 Jan 2001 22:44:09 -0500
Received: from squeaker.ratbox.org ([63.216.218.7]:53187 "HELO
	squeaker.ratbox.org") by vger.kernel.org with SMTP
	id <S129383AbRAPDnz>; Mon, 15 Jan 2001 22:43:55 -0500
Date: Mon, 15 Jan 2001 22:43:50 -0500 (EST)
From: Aaron Sethman <androsyn@ratbox.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pre5 VM feedback..
In-Reply-To: <940emj$6re$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0101152241400.1338-100000@squeaker.ratbox.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jan 2001, Linus Torvalds wrote:
> Now, I'm not saying your filesystem is toast.  I'm just saying that if
> you booted up in pre6, I'd suggest a quick reboot into a better kernel
> might be a good idea (be a jock, and do a sync and just push the reset
> button to force a proper fsck when it comes up - just in case).
> 
> (And yes, I renamed the pre6's really quickly, so you had to be unlucky
> to see them.)

Alas, I was one of those poor saps who got his / filesystem mangled a bit
by pre6.  Luckly nothing too horrid happened...just /etc/inittab happened
to not exist and other strangeness.  At least I know I am not losing my
mind now :)

Aaron

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
