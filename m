Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315725AbSEZF5W>; Sun, 26 May 2002 01:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315746AbSEZF5T>; Sun, 26 May 2002 01:57:19 -0400
Received: from bs1.dnx.de ([213.252.143.130]:60587 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S315725AbSEZF4V>;
	Sun, 26 May 2002 01:56:21 -0400
Date: Sun, 26 May 2002 07:45:40 +0200
From: Robert Schwebel <robert@schwebel.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020526074540.I598@schwebel.de>
In-Reply-To: <20020524223950.D22643@work.bitmover.com> <Pine.LNX.4.44.0205250152110.15928-100000@hawkeye.luckynet.adm> <20020525091444.H28795@work.bitmover.com> <3CEFB9C6.FC21D7CB@opersys.com> <20020525092557.K28795@work.bitmover.com> <3CEFBEA3.71611EDB@opersys.com> <20020526004710.A598@schwebel.de> <3CF03526.78F89E24@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2002 at 06:06:46PM -0700, Andrew Morton wrote:
> Could you please tell us, just so it is really clear, what these people's
> concerns are? What obstacles they see to using Linux in this industry?

Uncertainty. The situation today is that they are using operating systems
like WindowsCE, VxWorks, QNX or other proprietary operating systems. The
problem is that if you use an operating system for the industry you need to
make sure that you can support your product (=hardware: motion controller
or whatever) for about 10 to 15 years. That's pretty different to the IT
industry! Note also that these applications are very different from IT
applications: they are in most cases not of general use, but only if you
have the special hardware.  

This is the reason why _lots_ of people still use home brown solutions
based on DOS: they have the whole system under their control, nobody can
obsolete them the most significant part of their system. 

Industry people like Linux because it gives them exactly the combination of
freedom (=control over the source) and modern technology they need (note
that ethernet as a fieldbus replacement is a very promising technology). 

On the other hand, Linux still has a rest of the hacker image, at least to
the conservative automation people. When they hear that there is a patent
problem regarding to realtime they often see their central requirement
violated: longterm availability. Even the slightest sign of a potential
problem makes them often say: "Then we better stay with closed sorce,
because that's what we know."  

We don't require much: most of what's _technicall_ necessary is already
there. We just want the same right that every Linux programmer has for it's
software: decide ourself about the license of our self made application. 

Is tat too much? 

Robert
-- 
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+
