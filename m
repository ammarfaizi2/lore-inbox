Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261198AbREZPfp>; Sat, 26 May 2001 11:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261482AbREZPff>; Sat, 26 May 2001 11:35:35 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:1031 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S261198AbREZPfT>;
	Sat, 26 May 2001 11:35:19 -0400
Date: Sat, 26 May 2001 12:08:34 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ben LaHaise <bcrl@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
In-Reply-To: <20010526170306.X9634@athlon.random>
Message-ID: <Pine.LNX.4.21.0105261206260.30264-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2001, Andrea Arcangeli wrote:

> Others agreed that the real source of the create_buffers could be just
> too few reserved pages in the unused_list

To quote you, from the message to which I replied with the
"No Comment" comment:

------> Andrea Arcangeli wrote:
Anything supposed to work because there's enough memory between
zone->pages_min*3/4 and zone->pages_min/4 is just obviously broken
period.
------

And not 10 lines lower you decide to raise some magic
limit yourself. I guess my irony threshold must be
lower than yours, or something.

cheers,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)


