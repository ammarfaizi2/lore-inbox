Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135275AbREGSIl>; Mon, 7 May 2001 14:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135489AbREGSI2>; Mon, 7 May 2001 14:08:28 -0400
Received: from mail.gator.net ([209.251.152.21]:35856 "EHLO mail.gator.net")
	by vger.kernel.org with ESMTP id <S135275AbREGSEw>;
	Mon, 7 May 2001 14:04:52 -0400
Date: Mon, 7 May 2001 14:00:50 -0400 (EDT)
From: Blue Lang <blue@gator.net>
To: Francois Romieu <romieu@cogenit.fr>
cc: <alexander.eichhorn@rz.tu-ilmenau.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [Question] Explanation of zero-copy networking
In-Reply-To: <20010507195333.A13072@se1.cogenit.fr>
Message-ID: <Pine.LNX.4.30.0105071357520.943-100000@mail.gator.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 May 2001, Francois Romieu wrote:

> It shows that cached code performs well with ~0us latency device/memory.
>
> Networking is about latency and pps too. They both dramatically reduce
> the (axe-)evaluated bandwith.

I think his point is more along the lines of return on investment.  You
can tweak linux to move from 9MB/sec to 9.5MB/sec on a 100Mb link, or you
can spend those same developer cycles getting much larger returns out of
much sexier hardware.

Now, who's gonna supply us with those NICs? ;)

-- 
   Blue Lang                                    http://www.gator.net/~blue
   Unix Administrator                                     Veritas Software
   2315 McMullan Circle, Raleigh, North Carolina, USA         919 835 1540

