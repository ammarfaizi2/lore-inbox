Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315455AbSEYXjs>; Sat, 25 May 2002 19:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315456AbSEYXjr>; Sat, 25 May 2002 19:39:47 -0400
Received: from bs1.dnx.de ([213.252.143.130]:56746 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S315451AbSEYXjq>;
	Sat, 25 May 2002 19:39:46 -0400
Date: Sun, 26 May 2002 01:37:35 +0200
From: Robert Schwebel <robert@schwebel.de>
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020526013735.E598@schwebel.de>
In-Reply-To: <20020525143333.A17889@work.bitmover.com> <20020525215547.6912411972@denx.denx.de> <20020525150542.B17889@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2002 at 03:05:42PM -0700, Larry McVoy wrote:
> Let's review:
>     - we all agree that one possible way to guarentee that you are not in
>       violation of the free use license for the RTL patent is if 100% of
>       the code is GPLed, right?
>     - you and the other RTAI guys swear up and down that it is all GPLed.
> 
> So what's the problem?

That part of RTAI which uses the patented process is GPLed. Other parts,
which don't, are LGPL. Don't spread vague assumptions - tell us where you
think to have found a license violation or be quiet. It's not very helpful
to tell things in public which are simply not true. 

> Show me where I've done anything worth apologizing for and I'll consider
> it.

You blame the RTAI developers for license violations without any proof. 

Robert
-- 
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+
