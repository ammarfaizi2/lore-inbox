Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131195AbQLUS0q>; Thu, 21 Dec 2000 13:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131312AbQLUS0f>; Thu, 21 Dec 2000 13:26:35 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:24046 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131195AbQLUS0W>; Thu, 21 Dec 2000 13:26:22 -0500
Date: Thu, 21 Dec 2000 15:55:28 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <andrewm@uow.edu.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: Linux 2.2.19pre2
In-Reply-To: <20001221184424.C29083@athlon.random>
Message-ID: <Pine.LNX.4.21.0012211554420.1613-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Dec 2000, Andrea Arcangeli wrote:

> It would also be nice if you could show a real life
> showstopper-production-bottleneck where we need C) to fix it. I
> cannot see any useful usage of C in production 2.2.x.

Me neither.  I'm just wondering at the reason why 2.2 semantics
would be different than 2.4 ones now we still have the choice
of just cut'n'pasting over the (working) code from 2.4...

regards,

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
