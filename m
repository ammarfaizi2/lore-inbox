Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318409AbSGYLJl>; Thu, 25 Jul 2002 07:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318411AbSGYLJl>; Thu, 25 Jul 2002 07:09:41 -0400
Received: from chaos.analogic.com ([204.178.40.224]:57729 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318409AbSGYLJl>; Thu, 25 Jul 2002 07:09:41 -0400
Date: Thu, 25 Jul 2002 07:14:13 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Andries Brouwer <aebr@win.tue.nl>
cc: Kareem Dana <kareemy@earthlink.net>, Andrew Rodland <arodland@noln.com>,
       linux-kernel@vger.kernel.org
Subject: Re: loop.o device busy after umount
In-Reply-To: <20020724212521.GA13196@win.tue.nl>
Message-ID: <Pine.LNX.3.95.1020725070956.11258A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2002, Andries Brouwer wrote:

> On Wed, Jul 24, 2002 at 04:03:29PM -0400, Richard B. Johnson wrote:
> 
> > > Read mount(8), the places where losetup is mentioned.
> > 
> > It works in my system and `umount` is version 2.10o
> > It works because (strace output), umount does the LOOP_CLR_FD ioctl().
> 
> Why do you repeat an imprecise answer? Read mount(8).

Hardly imprecise. "Read mount(8)..." From what distribution? I gave
the precise reason why umount 2.10o works, not some wise-guy retort
that presumes that everybody has some specific distribution with
your version of man pages.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

