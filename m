Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286876AbRL1MeY>; Fri, 28 Dec 2001 07:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286882AbRL1MeP>; Fri, 28 Dec 2001 07:34:15 -0500
Received: from fepF.post.tele.dk ([195.41.46.135]:48631 "EHLO
	fepF.post.tele.dk") by vger.kernel.org with ESMTP
	id <S286876AbRL1MeD>; Fri, 28 Dec 2001 07:34:03 -0500
Date: Fri, 28 Dec 2001 13:33:50 +0100
From: Jens Axboe <axboe@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andre Hedrick <andre@linux-ide.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Daniel Stodden <stodden@in.tum.de>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Message-ID: <20011228133350.B834@suse.de>
In-Reply-To: <20011228115956.E2973@suse.de> <Pine.LNX.4.33L.0112281028070.24031-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0112281028070.24031-100000@imladris.surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28 2001, Rik van Riel wrote:
> On Fri, 28 Dec 2001, Jens Axboe wrote:
> > On Thu, Dec 27 2001, Andre Hedrick wrote:
> 
> > > BUZZIT on your total lack of documention the the changes to the
> > > request_struct, otherwise I could follow your mindset and it would not be
> > > a pissing contest.
> >
> > Tried reading the source?
> 
> As usual, without documentation you only know what the code
> does, not what it's supposed to do or why it does it.
> 
> Documentation is an essential ingredient when hunting for
> bugs in the code, because without the docs you have to guess
> whether something is a bug or not, while with docs it's much
> easier to identify inconsistencies.

please look at the source before making such comments -- it's quite
adequately commented.

-- 
Jens Axboe

