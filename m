Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285190AbRL2SP6>; Sat, 29 Dec 2001 13:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285196AbRL2SPs>; Sat, 29 Dec 2001 13:15:48 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:51729 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S285190AbRL2SPd>;
	Sat, 29 Dec 2001 13:15:33 -0500
Date: Sat, 29 Dec 2001 19:15:16 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.5.1-p1 (Re: patch-2.4.15: Fix CompactFlash+PCMCIA+PCI system freeze (Resend)) (fwd)
Message-ID: <20011229191516.J1821@suse.de>
In-Reply-To: <Pine.LNX.4.10.10112281002240.24491-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10112281002240.24491-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28 2001, Andre Hedrick wrote:
> 
> Funny but I find it strange this did not end up on LKML, and I did
> submit a patch prior to BIO release but you never got it.

Don't get paranoid.

> To bad you never saw it and I know for a fact that I discussed all of
> these issue w/ out before BIO and even asked you to explain all the BIO
> stuff ahead of time for the off chance that BIO entered first.
> 
> Feel free to call BS on this but you and I know it is true as do a much if
> people IRC'ng.

No that's correct, however the call to add bio before any IDE updates
was not mine nor yours to make. 

-- 
Jens Axboe

