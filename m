Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261973AbSKYSBH>; Mon, 25 Nov 2002 13:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262446AbSKYSBH>; Mon, 25 Nov 2002 13:01:07 -0500
Received: from chaos.analogic.com ([204.178.40.224]:31620 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261973AbSKYSBG>; Mon, 25 Nov 2002 13:01:06 -0500
Date: Mon, 25 Nov 2002 13:10:41 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Dennis Grant <trog@wincom.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: A Kernel Configuration Tale of Woe
In-Reply-To: <3de26215.842.0@wincom.net>
Message-ID: <Pine.LNX.3.95.1021125125850.4431B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2002, Dennis Grant wrote:

This is the linux-kernel list. Nothing you said has anything to
do with the linux-kernel. Various distributions have various
kinds of installation menus. These are not anything that have
anything to do with the kernel. If you want to change your
configuration on-the-fly, you just use modules. It's that
easy.

Your tale of woe just shows that you are unfamiliar with
whatever Linux Distribution you are using and, your expectations
that somebody here should hear about it on this list shows that you
don't know what "kernel" means.

Next. Fix your line-wrap. Your mail is unreadable on `pine` and/or
the usual Unix tools like `mail`.

> But after this past weekend's horror movie, I wish to make 3 points and impassioned
> pleas to all y'all.
> 
> 1) The current kernel configuration process is overly complex for initial configuration
> of new hardware. There needs to be some sort of higher-level configuration level
> that addresses kernel subsystems on a "hardware component" level rather than
> an individual chip driver level.

> 
> What I want is some sort of configuration interface that lets me enter or select
> my hardware components on an "item" level by manufacturer and model number rather
> than what the thing is actually made of.

If you want one of these things, you just make one. You can use a kernel
compiled for modules and make  a GUI or whatever that searches for the
correct module to install for your hardware. That's what the RH
distribution does for its initial configuration. It also checks for
new devices upon each startup. If you want something different, just
make one.

If you think you can make a kernel configuration program that will
work in text-mode as well as graphics, and you don't like the current
one, you just make one. If it's really good, you can get it to be
part of the kernel distribution. But I warn you, it is not as simple
as you seem to believe.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


