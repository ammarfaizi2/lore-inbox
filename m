Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131010AbQKRBwT>; Fri, 17 Nov 2000 20:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131056AbQKRBwJ>; Fri, 17 Nov 2000 20:52:09 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:17160 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131010AbQKRBwC>; Fri, 17 Nov 2000 20:52:02 -0500
Date: Fri, 17 Nov 2000 17:21:53 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andries.Brouwer@cwi.nl
cc: aeb@veritas.com, emoenke@gwdg.de, eric@andante.org,
        kobras@tat.physik.uni-tuebingen.de, koenig@tat.physik.uni-tuebingen.de,
        linux-kernel@vger.kernel.org
Subject: Re: BUG: isofs broken (2.2 and 2.4)
In-Reply-To: <UTC200011180017.BAA126953.aeb@aak.cwi.nl>
Message-ID: <Pine.LNX.4.10.10011171720410.5987-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



There's a test11-pre7 there now, and I'd really ask people to check out
the isofs changes because slight worry about those is what held me up from
just calling it test11 outright.

It's almost guaranteed to be better than what we had before, but anyway..

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
