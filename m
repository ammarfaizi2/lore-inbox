Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313712AbSDUSLh>; Sun, 21 Apr 2002 14:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313714AbSDUSLg>; Sun, 21 Apr 2002 14:11:36 -0400
Received: from bitmover.com ([192.132.92.2]:36507 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S313712AbSDUSLe>;
	Sun, 21 Apr 2002 14:11:34 -0400
Date: Sun, 21 Apr 2002 11:11:34 -0700
From: Larry McVoy <lm@bitmover.com>
To: CaT <cat@zip.com.au>
Cc: Daniel Phillips <phillips@bonn-fries.net>, Larry McVoy <lm@bitmover.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org
Subject: Re: Suggestion re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020421111134.O10525@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>, CaT <cat@zip.com.au>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Larry McVoy <lm@bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204201039130.19512-100000@home.transmeta.com> <20020421171629.GK4640@zip.com.au> <20020421104046.J10525@work.bitmover.com> <E16yz02-0000lC-00@starship> <20020421175404.GL4640@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's what I meant. Email gets sent out to LKML when the patch gets sent
> to BK for approval by Linus. Another email can then be sent out (unless
> it's felt that it's too verbose to do so) when Linus accepts it into the
> tree. (unless I'm missing something about BK ;)

OK, I think you are missing some details of the workflow used to get patches
to Linus.  As far as I know, he mostly pulls rather than accepts patches,
that's one of the reasons there are so many different kernel repositories
on bkbits.net.  They are mostly queues of stuff waiting for Linus to pull
them. 

If that is correct, then what we really want is email when something
lands on bkbits.net and is not yet included in Linus' tree.  We can
certainly set up a trigger to send email in that case.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
