Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264141AbUAYM0q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 07:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264142AbUAYM0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 07:26:46 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:56839 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264141AbUAYM0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 07:26:45 -0500
Subject: Re: Request: I/O request recording
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0401241550350.14163-100000@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.44.0401241550350.14163-100000@bigblue.dev.mdolabs.com>
Content-Type: text/plain
Message-Id: <1075033601.861.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Sun, 25 Jan 2004 13:26:41 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-01-25 at 00:53, Davide Libenzi wrote:
> > So it's all an attempt to optimise the boot-time I/O patterns.  It was
> > pretty much a waste of time, gaining only 10% or so, from memory.  You
> > could get just as much or more speedup from simply launching all the
> > initscripts in parallel, although this did tend to break stuff.
> > 
> > Anyway, the code's ancient but might provide some ideas:
> > 
> > 	http://www.zip.com.au/~akpm/linux/fboot.tar.gz
> 
> Warning. I don't know if they do have a patent for this, but MS does this 
> starting from XP (look inside %WINDIR%\PreFetch). It is both boot and app 
> based.

And tomorrow, they'll say the have patented the hamburger recipe, or the
euclidean triangle, or... who knows. C'mon... The world is going crazy!

