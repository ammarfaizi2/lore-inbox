Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313660AbSEMODX>; Mon, 13 May 2002 10:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313661AbSEMODW>; Mon, 13 May 2002 10:03:22 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:40714 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S313660AbSEMODV>; Mon, 13 May 2002 10:03:21 -0400
Date: Mon, 13 May 2002 10:34:40 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Zlatko Calusic <zlatko.calusic@iskon.hr>
cc: Bill Davidsen <davidsen@tmr.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] IO wait accounting
In-Reply-To: <dnvg9sfez1.fsf@magla.zg.iskon.hr>
Message-ID: <Pine.LNX.4.44L.0205131034110.32261-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2002, Zlatko Calusic wrote:

> Anyway, here is how Aix defines it:
>
>  Average percentage of CPU time that the CPUs were idle during which
>  the system had an outstanding disk I/O request. This value may be
>  inflated if the actual number of I/O requesting threads is less than
>  the number of idling processors.

Ohhh, I ran into this implementation detail, too ;)

I hope that means I'm doing something right.

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

