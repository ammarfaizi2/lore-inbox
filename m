Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbQLaNVq>; Sun, 31 Dec 2000 08:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbQLaNVh>; Sun, 31 Dec 2000 08:21:37 -0500
Received: from ferret.lmh.ox.ac.uk ([163.1.138.204]:55050 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S129324AbQLaNVQ>; Sun, 31 Dec 2000 08:21:16 -0500
Date: Sun, 31 Dec 2000 12:50:49 +0000 (GMT)
From: Chris Evans <chris@scary.beasts.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Steven Cole <elenstev@mesatop.com>, <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre7...
In-Reply-To: <Pine.LNX.4.10.10012301910420.1904-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0012311249560.20938-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 30 Dec 2000, Linus Torvalds wrote:

> On Sat, 30 Dec 2000, Steven Cole wrote:
> >
> > It looks like 2.4.0-test13-pre7 is a clear winner when running dbench 48
> > on my somewhat slow test machine (450 Mhz P-III, 192MB, IDE).
>
> This is almost certainly purely due to changing (some would say "fixing")
> the bdflush synchronous wait point.

Nice:)

Did Rik's drop_behind performance fix make it in or can we look forward to
another jump in the dbench benchmarks?

Cheers
Chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
