Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbTELXU4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 19:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262933AbTELXU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 19:20:56 -0400
Received: from chaos.analogic.com ([204.178.40.224]:54408 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262932AbTELXUz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 19:20:55 -0400
Date: Mon, 12 May 2003 19:36:49 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
cc: Russell King <rmk@arm.linux.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Paul Fulghum <paulkf@microgate.com>,
       David Hinds <dahinds@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCMCIA 2.5.X sleeping from illegal context
In-Reply-To: <1052781365.1185.5.camel@teapot.felipe-alfaro.com>
Message-ID: <Pine.LNX.4.53.0305121929300.6225@chaos>
References: <1052775331.1995.49.camel@diemos>  <1052773631.31825.18.camel@dhcp22.swansea.linux.org.uk>
  <20030512233151.B17227@flint.arm.linux.org.uk> <1052781365.1185.5.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2003, Felipe Alfaro Solana wrote:

> On Tue, 2003-05-13 at 00:31, Russell King wrote:
> > > Does this still happen with all the patches Russell King posted
> > > that everyone else is ignoring ?
> >
> > I'm in the process of putting the patch in my outgoing patch queue
> > for Linus, otherwise we're not going to make any forward progress.
>
> Well, your patches do work pretty well for me... I've been playing
> extensively with PCMCIA today, mainly with my 3Com CardBus NIC which has
> really strange TX slowdown problems, by plugging and unplugging it over
> and over again, loading and unloading the 3c59x.ko module and so on. So
> at least, we're making some progress.


Could somebody please change the error message? Although everybody
seems to want to be a lawyer, even lawyers don't make law. Certainly
Software Engineers don't. The correct word is 'invalid', not 'illegal'.
Yes, I know there is a 30-year history of the use of that word in
Unix, but it's wrong. Only governments make law.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

