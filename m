Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315451AbSEYXkz>; Sat, 25 May 2002 19:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315459AbSEYXjv>; Sat, 25 May 2002 19:39:51 -0400
Received: from bs1.dnx.de ([213.252.143.130]:58026 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S315454AbSEYXjq>;
	Sat, 25 May 2002 19:39:46 -0400
Date: Sun, 26 May 2002 00:58:27 +0200
From: Robert Schwebel <robert@schwebel.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020526005827.B598@schwebel.de>
In-Reply-To: <Pine.LNX.4.44.0205250152110.15928-100000@hawkeye.luckynet.adm> <Pine.LNX.4.44.0205251015350.6515-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2002 at 10:22:00AM -0700, Linus Torvalds wrote:
> So you split your problem into the RT device driver and the user. And of
> story. 

Not possible with closed loop applications.  

> The thing that disgusts me is that this "patent" thing is used as a
> complete red herring, and the real issue is that some people don't like
> the fact that the kernel is under the GPL. 

I personally and every other RTAI developer I know is pretty happy with the
Kernel being under the GPL. We are all very active free software
developers, supporters and promoters, believe me. That's not the problem.
We are only talking about the "closed-loop-applications" problem here. 

Robert
-- 
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+
