Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314395AbSEYJOF>; Sat, 25 May 2002 05:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314392AbSEYJNG>; Sat, 25 May 2002 05:13:06 -0400
Received: from bs1.dnx.de ([213.252.143.130]:45991 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S314325AbSEYJND>;
	Sat, 25 May 2002 05:13:03 -0400
Date: Sat, 25 May 2002 11:05:42 +0200
From: Robert Schwebel <robert@schwebel.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020525110542.T598@schwebel.de>
In-Reply-To: <3CEEC729.74625C2B@opersys.com> <Pine.LNX.4.44.0205241619590.28735-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 04:27:24PM -0700, Linus Torvalds wrote:
> Whatever non-RT tools used to visualize the RT data equally clearly
> aren't covered by _that_ particular patent, so I think the whole thing is
> a complete and utter red herring.

Unfortunately, it is not only visualisation programs we are talking about,
but also fast data processing algorithms, which are bread and butter of the
users of realtime controllers. See my other post for an example. 

Robert
-- 
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+
