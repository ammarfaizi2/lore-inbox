Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286992AbRL1Thl>; Fri, 28 Dec 2001 14:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286993AbRL1Thb>; Fri, 28 Dec 2001 14:37:31 -0500
Received: from fep04.swip.net ([130.244.199.132]:29917 "EHLO
	fep04-svc.swip.net") by vger.kernel.org with ESMTP
	id <S286992AbRL1ThV>; Fri, 28 Dec 2001 14:37:21 -0500
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>
Subject: Re: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
In-Reply-To: <20011228115956.E2973@suse.de>
	<Pine.LNX.4.33L.0112281028070.24031-100000@imladris.surriel.com>
	<20011228133350.B834@suse.de>
From: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>
Date: 28 Dec 2001 20:30:58 +0100
In-Reply-To: <20011228133350.B834@suse.de>
Message-ID: <m2666rta4t.fsf@pengo.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

> On Fri, Dec 28 2001, Rik van Riel wrote:
> > On Fri, 28 Dec 2001, Jens Axboe wrote:
> > >
> > > Tried reading the source?
> >
> > As usual, without documentation you only know what the code
> > does, not what it's supposed to do or why it does it.
>
> please look at the source before making such comments -- it's quite
> adequately commented.

I agree, but I have one specific question though. What are the
bi_end_io() functions supposed to return? The return value doesn't
ever seem to be used (yet?), so reading the source code can not answer
that question.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
