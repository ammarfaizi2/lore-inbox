Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbRADRA7>; Thu, 4 Jan 2001 12:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129927AbRADRAt>; Thu, 4 Jan 2001 12:00:49 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:37111 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129348AbRADRAk>; Thu, 4 Jan 2001 12:00:40 -0500
Date: Thu, 4 Jan 2001 14:59:49 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@e-mind.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcache 2nd chance replacement
In-Reply-To: <20010104175238.F1507@athlon.random>
Message-ID: <Pine.LNX.4.21.0101041459050.1188-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001, Andrea Arcangeli wrote:

> This is totally offtopic. We were _not_ talking about other
> algorithms.  We were _only_ talking about _when_ the 1 bit of
> aging I introduced with my algorithm improves performance at
> max.  My answer is that the max performance improvement happens
> when there's the _highest_ VFS load in background and you
> disagreed.  Everything else has nothing to do with this our
> previous discussion so your above reply partly still doesn't
> make sense to me.

Not only did I disagree, I also explained you why it
doesn't work the way you envision.

Unfortunately you seem to ignore my arguments, so lets
close this thread.

EOT,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
