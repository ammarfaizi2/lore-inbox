Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313743AbSDUSyY>; Sun, 21 Apr 2002 14:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313744AbSDUSyX>; Sun, 21 Apr 2002 14:54:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3335 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313743AbSDUSyX>; Sun, 21 Apr 2002 14:54:23 -0400
Date: Sun, 21 Apr 2002 11:53:57 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Larry McVoy <lm@bitmover.com>
cc: CaT <cat@zip.com.au>, Daniel Phillips <phillips@bonn-fries.net>,
        Anton Altaparmakov <aia21@cantab.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Suggestion re: [PATCH] Remove Bitkeeper documentation from Linux
 tree
In-Reply-To: <20020421104046.J10525@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0204211146170.17272-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Apr 2002, Larry McVoy wrote:
>
> I can certainly do this for the tree on bkbits.net, i.e., it emails the
> lk list when it gets new work.  Linus?

I'll look at automating something at this end, because I might as well
also automate the push the both master.kernel.org and to bkbits.net:
right now I do that only when I happen to think about it.

			Linus

