Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263035AbTCLEF6>; Tue, 11 Mar 2003 23:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263023AbTCLEF6>; Tue, 11 Mar 2003 23:05:58 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:56325 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S263035AbTCLEF5>; Tue, 11 Mar 2003 23:05:57 -0500
Date: Tue, 11 Mar 2003 23:16:21 -0500
From: Ben Collins <bcollins@debian.org>
To: Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030312041621.GE563@phunnypharm.org>
References: <20030312034330.GA9324@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030312034330.GA9324@work.bitmover.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The payoff for you is that you have the data in a format that is not
> locked into some tool which could be taken away.  The payoff for us is
> that we can evolve our tool as we see fit.  We have that right today,
> we can do whatever we want, but it would be anywhere from annoying
> to unethical to do so if that meant that you couldn't get at the data
> except through BitKeeper.  So the "deal" here is that you get the data
> in CVS (and/or patches + comments) and we get to hack the heck out of
> the file format.  Our changes are going to move far faster than CSSC or
> anyone else could keep up without a lot of effort.  On the other hand,
> our changes are going to make cold cache performance be much closer to
> hot cache performance, use a lot less disk space, a lot less memory,
> and a lot less CPU.

Larry, I don't mean to start yet another anti-bitmover, anti-bitkeeper or
anti-larry flame-fest, but I have to be honest that I am a little bit
worried.

You are giving us approximately 90% of our data in exchange for the one
thing that made using bitkeeper not a total sellout; the fact that the
revision history of the repo was still accessible without proprietary
software.

I honestly appreciate the work that you and BitMover do for the kernel,
but not giving us access to 100% of _our_ data is unacceptable to me.
Quite honestly, I think your move is to restrict the possible
alternatives to the BK client (the CSSC based ones like I and others had
done), which were able to extract 100% of the data, even if they
couldn't make use of it in the same way as bitkeeper. Atleast it was
there.

You've made quite a marketing move. It's obvious to me, maybe not to
others. By providing this CVS gateway, you make it almost pointless to
work on an alternative client. Also by providing it, you make it easier
to get away with locking the revision history into a proprietary format.



-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
