Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292187AbSBUGax>; Thu, 21 Feb 2002 01:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292314AbSBUGan>; Thu, 21 Feb 2002 01:30:43 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:39378 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S287200AbSBUGa0>; Thu, 21 Feb 2002 01:30:26 -0500
Date: Thu, 21 Feb 2002 08:19:42 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Christer Weinigel <wingel@nano-system.com>
Cc: roy@karlsbakk.net, <linux-kernel@vger.kernel.org>
Subject: Re: SC1200 support?
In-Reply-To: <20020221000202.363E6F5B@acolyte.hack.org>
Message-ID: <Pine.LNX.4.44.0202210816140.7649-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002, Christer Weinigel wrote:

> Roy Sigurd Karlsbakk wrote:
> >I have this set-top box with a National Semiconductor Geode SC1200 chip
> >with a built-in watch-dog plus a lot more.
> >
> >Does anyone know if there is any support for the sc1200-specific features
> >in the current kernels, or if there are patches available?
> 
> Darn, I've been meaning to clean these patches up for a month or so,
> but I haven't had the time yet.  I've made a snapshot of my CVS tree
> that you can find at:
> 
>     http://www.nano-system.com/scx200/

Wow i'm a complete moron, just spent two hours last night cooking up a 
watchdog driver, and all along you had it squirreled away somewhere =) 
Next time i'll go to the pub.

Cheers,
	Zwane Mwaikambo


