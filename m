Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282690AbSADSZQ>; Fri, 4 Jan 2002 13:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288711AbSADSZJ>; Fri, 4 Jan 2002 13:25:09 -0500
Received: from ns.suse.de ([213.95.15.193]:47621 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S282690AbSADSYk>;
	Fri, 4 Jan 2002 13:24:40 -0500
Date: Fri, 4 Jan 2002 19:24:39 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.5.2.7: io.h cleanup and userspace nudge
In-Reply-To: <3C35F290.140BB2C7@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0201041924220.20620-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002, Jeff Garzik wrote:

> But...   my patch is merely a small step, a "nudge" as I mentioned.  I
> don't want to annhilate the glibc developers with a sudden task, just a
> nudge :)

Then s/#error/#warning/  8)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

