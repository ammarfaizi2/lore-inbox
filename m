Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291429AbSBHGGj>; Fri, 8 Feb 2002 01:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291430AbSBHGGa>; Fri, 8 Feb 2002 01:06:30 -0500
Received: from bitmover.com ([192.132.92.2]:24550 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S291429AbSBHGGU>;
	Fri, 8 Feb 2002 01:06:20 -0500
Date: Thu, 7 Feb 2002 22:06:19 -0800
From: Larry McVoy <lm@bitmover.com>
To: Troy Benjegerdes <hozer@drgw.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Message-ID: <20020207220619.A18469@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Troy Benjegerdes <hozer@drgw.net>,
	Linus Torvalds <torvalds@transmeta.com>,
	Stelian Pop <stelian.pop@fr.alcove.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020207080714.GA10860@come.alcove-fr> <Pine.LNX.4.33.0202070833400.2269-100000@athlon.transmeta.com> <20020207092640.P27932@work.bitmover.com> <20020207232858.M17426@altus.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020207232858.M17426@altus.drgw.net>; from hozer@drgw.net on Thu, Feb 07, 2002 at 11:28:58PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ideally, this should ask what changesets you want to send, and what 
> public tree to look at to see *what* makes sense to send.

In BK 2.1.4 we added a 

	bk send -u<url> email

which does the sync with the URL and sends only what you have that the
URL doesn't have.  But you have to be running 2.1.4 on both ends.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
