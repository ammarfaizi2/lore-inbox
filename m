Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135832AbRDYHrW>; Wed, 25 Apr 2001 03:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135833AbRDYHrL>; Wed, 25 Apr 2001 03:47:11 -0400
Received: from ucu-105-116.ucu.uu.nl ([131.211.105.116]:49264 "EHLO
	ronald.bitfreak.net") by vger.kernel.org with ESMTP
	id <S135832AbRDYHqv>; Wed, 25 Apr 2001 03:46:51 -0400
Date: Wed, 25 Apr 2001 09:46:25 +0200
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Single user linux
Message-ID: <20010425094625.I20175@tux.bitfreak.net>
In-Reply-To: <20010425103456.D11099@piro.kabuki.openfridge.net> <Pine.LNX.4.10.10104241751010.6846-100000@innerfire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.10.10104241751010.6846-100000@innerfire.net>; from gmack@innerfire.net on Wed, Apr 25, 2001 at 02:52:22 +0200
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.04.25 02:52:22 +0200 Gerhard Mack wrote:
> On Wed, 25 Apr 2001, Daniel Stone wrote:
> 
> > OK. "time make bzImage". Of course, mine's really slow (and I will
> consider
> > myself publically humiliated if my only Linux machine is beaten on a
> kernel
> > compile by an iPAQ). I 'spose, if it only goes into suspend, the
> ability to
> > write "uptime" on it constitutes a walking penis extension after a
> while?
> 
> When I first started I compiled my linux kernels on a 386 dx with 8 mb
> ram
> heh.  I think a lot of the current PDAs are faster.

Who says it needs to compile? Who says it needs software installed? Who
says it needs to run the software itself?

First of all, if linux will make it on a PDA, I'm sure there will be
prepackaged stuff. But more important, a PDA doesn't need other software
installed to have a function. It can function as a remote X-terminal
connected to a big linux X-server somewhere else which runs the software.
In that case, the speed of the PDA is no longer a problem and you have a
cute little and simple fully-featured X-window system. It's just a bit
small. Now if we get something like IBM's speach recognition system and it
works a bit, or we make our own speach recognition system, this can serve
very well for simple things like adding points to your agenda, writing
e-mail. But for just reading your mail or your agenda, you don't need more
than to press some buttons and read the screen. And for pressing the
buttons you really don't need anything else than a touchscreen or some (1?
2?) buttons on the PDA...

And for using linux as a command-line too on a PDA - we'll need something
to make input easier, like Aaron Lehman suggested in another e-mail
(keyboard, speach recognition). 

--
Ronald Bultje

