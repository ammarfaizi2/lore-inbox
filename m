Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313448AbSDUSME>; Sun, 21 Apr 2002 14:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313702AbSDUSMD>; Sun, 21 Apr 2002 14:12:03 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:15013 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S313448AbSDUSMB>;
	Sun, 21 Apr 2002 14:12:01 -0400
Date: Sun, 21 Apr 2002 14:12:00 -0400
From: Jeff Garzik <garzik@havoc.gtf.org>
To: CaT <cat@zip.com.au>
Cc: Daniel Phillips <phillips@bonn-fries.net>, Larry McVoy <lm@bitmover.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org
Subject: Re: Suggestion re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020421141200.D8142@havoc.gtf.org>
In-Reply-To: <Pine.LNX.4.44.0204201039130.19512-100000@home.transmeta.com> <20020421171629.GK4640@zip.com.au> <20020421104046.J10525@work.bitmover.com> <E16yz02-0000lC-00@starship> <20020421175404.GL4640@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2002 at 03:54:04AM +1000, CaT wrote:
> That's what I meant. Email gets sent out to LKML when the patch gets sent
> to BK for approval by Linus. Another email can then be sent out (unless
> it's felt that it's too verbose to do so) when Linus accepts it into the
> tree. (unless I'm missing something about BK ;)

This doesn't work -- there is no BK _push_ to Linus.  There is no "sent
to BK for approval."

Traditional RFC822 email is sent to Linus, telling him that there are BK
changesets to be picked up.  A human-defined length of time ensues,
after which Linus either ignores or comments on the email, and either
does a 'bk pull' or not.

Very similar to the way GNU patches are handled, strangely enough ;-)

	Jeff



