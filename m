Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132939AbQLHVmP>; Fri, 8 Dec 2000 16:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132985AbQLHVmF>; Fri, 8 Dec 2000 16:42:05 -0500
Received: from www.rccacm.org ([209.166.59.114]:1299 "EHLO www.rccacm.org")
	by vger.kernel.org with ESMTP id <S132954AbQLHVlt>;
	Fri, 8 Dec 2000 16:41:49 -0500
Date: Fri, 8 Dec 2000 12:55:51 -0800 (PST)
From: Bryan Whitehead <driver@rccacm.org>
To: David Riley <oscar@the-rileys.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Disableing USB.
In-Reply-To: <3A3037E9.6D5378A8@the-rileys.net>
Message-ID: <Pine.LNX.4.21.0012081250481.27549-100000@www.rccacm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Er... Well, the traditional solution has been "don't build it into your
> kernel if you don't want it", but in the case of stock kernels, that
> isn't always an option, I suppose.  Theoretically, the two devices
> shouldn't step on each other, but this is a computer.  Theory is so far
> removed from practice that it's... Well, I can't think up a good
> analogy.  It's far.
> 
> *looks at kernel config options*
> 
> Well, it looks like the usb cores (UHCI and OHCI) can be modular.  Why
> aren't they in the stock kernel, other than possibly autodetection
> problems?  If they are built as modules, using expert mode in RedHat or
> whatever equivalent may be in other dists may let you avoid insmodding
> the USB stuff...

Nope. Expert just means you'll be doing allot of stuff manually, Like
partitioning, package selection, configureing X, and some net stuff. 

> Beyond that, having a command-line disable feature does seem pretty
> neat.  Although why would you want to disable procfs?  Maybe I missed
> something there, but it seems awful darn important to leave out. :-)

I was just using that as an example. Being able to disbale whatever part
of the kernel you want might be really helpfull in many cases... Maybe
procfs was a bad example... :P


-- 
---
Bryan Whitehead
Email: driver@rccacm.org
WorkE: driver@jpl.nasa.gov

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
