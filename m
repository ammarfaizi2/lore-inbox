Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282918AbRL1NBI>; Fri, 28 Dec 2001 08:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282914AbRL1NA6>; Fri, 28 Dec 2001 08:00:58 -0500
Received: from fepz.post.tele.dk ([195.41.46.133]:20678 "EHLO
	fepZ.post.tele.dk") by vger.kernel.org with ESMTP
	id <S286898AbRL1NAr>; Fri, 28 Dec 2001 08:00:47 -0500
Date: Fri, 28 Dec 2001 14:00:35 +0100
From: Jens Axboe <axboe@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andre Hedrick <andre@linux-ide.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Daniel Stodden <stodden@in.tum.de>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Message-ID: <20011228140035.A1248@suse.de>
In-Reply-To: <20011228115956.E2973@suse.de> <Pine.LNX.4.33L.0112281028070.24031-100000@imladris.surriel.com> <20011228133350.B834@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011228133350.B834@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28 2001, Jens Axboe wrote:
> On Fri, Dec 28 2001, Rik van Riel wrote:
> > On Fri, 28 Dec 2001, Jens Axboe wrote:
> > > On Thu, Dec 27 2001, Andre Hedrick wrote:
> > 
> > > > BUZZIT on your total lack of documention the the changes to the
> > > > request_struct, otherwise I could follow your mindset and it would not be
> > > > a pissing contest.
> > >
> > > Tried reading the source?
> > 
> > As usual, without documentation you only know what the code
> > does, not what it's supposed to do or why it does it.
> > 
> > Documentation is an essential ingredient when hunting for
> > bugs in the code, because without the docs you have to guess
> > whether something is a bug or not, while with docs it's much
> > easier to identify inconsistencies.
> 
> please look at the source before making such comments -- it's quite
> adequately commented.

Lest I forget to mention this again -- also see Suparna's excellent
notes on the new block I/O layer:

http://lse.sourceforge.net/io/bionotes.txt

And my own write-up right here on lkml:

http://marc.theaimsgroup.com/?t=100695031900001&r=1&w=2


-- 
Jens Axboe

