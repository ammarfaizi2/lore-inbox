Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286871AbRL1MaO>; Fri, 28 Dec 2001 07:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286868AbRL1M3y>; Fri, 28 Dec 2001 07:29:54 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:51972 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S286871AbRL1M3p>;
	Fri, 28 Dec 2001 07:29:45 -0500
Date: Fri, 28 Dec 2001 10:29:37 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andre Hedrick <andre@linux-ide.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Daniel Stodden <stodden@in.tum.de>, <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
In-Reply-To: <20011228115956.E2973@suse.de>
Message-ID: <Pine.LNX.4.33L.0112281028070.24031-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2001, Jens Axboe wrote:
> On Thu, Dec 27 2001, Andre Hedrick wrote:

> > BUZZIT on your total lack of documention the the changes to the
> > request_struct, otherwise I could follow your mindset and it would not be
> > a pissing contest.
>
> Tried reading the source?

As usual, without documentation you only know what the code
does, not what it's supposed to do or why it does it.

Documentation is an essential ingredient when hunting for
bugs in the code, because without the docs you have to guess
whether something is a bug or not, while with docs it's much
easier to identify inconsistencies.

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

