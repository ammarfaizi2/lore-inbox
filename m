Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264393AbRFNBv6>; Wed, 13 Jun 2001 21:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264398AbRFNBvs>; Wed, 13 Jun 2001 21:51:48 -0400
Received: from viper.haque.net ([66.88.179.82]:5760 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S264393AbRFNBvh>;
	Wed, 13 Jun 2001 21:51:37 -0400
Date: Wed, 13 Jun 2001 21:51:21 -0400 (EDT)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: Daniel <ddickman@nyc.rr.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: obsolete code must die
In-Reply-To: <01a401c0f46b$20b932e0$480e6c42@almlba4sy7xn6x>
Message-ID: <Pine.LNX.4.33.0106132145430.1172-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2001, Daniel wrote:

> -- Getting rid of old code can help simplify the kernel. This means less
> chance of bugs.
> -- Simplifying the kernel means that it will be easier for newbies to
> understand and perhaps contribute.
> -- a simpler, cleaner kernel will also be of more use in an academic
> environment.
> -- a smaller kernel is easier to maintain and is easier to re-architect
> should the need arise.
> -- If someone really needs support for this junk, they will always have the
> option of using the 2.0.x, 2.2.x or 2.4.x series.
....
> i386, i486
> The Pentium processor has been around since 1995. Support for these older
> processors should go so we can focus on optimizations for the pentium and
> better processors.
>
> ISA bus, MCA bus, EISA bus
> PCI is the defacto standard. Get rid of CONFIG_BLK_DEV_ISAPNP,
> CONFIG_ISAPNP, etc
>
> ISA, MCA, EISA device drivers
> If support for the buses is gone, there's no point in supporting devices for
> these buses.

One of the things that makes linux great is being able to actually put
all that old hardware to use. Heck, I know people who use Mac SE still
(running BSD though .. but still same idea).

Yeah, sure I can run older kernels. But what if I want say .. the new
and improved VM that's available in say 2.6? What then?

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

