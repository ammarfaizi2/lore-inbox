Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310482AbSCGTdN>; Thu, 7 Mar 2002 14:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310481AbSCGTdC>; Thu, 7 Mar 2002 14:33:02 -0500
Received: from bitmover.com ([192.132.92.2]:52361 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S310480AbSCGTcr>;
	Thu, 7 Mar 2002 14:32:47 -0500
Date: Thu, 7 Mar 2002 11:32:46 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Petition Against Official Endorsement of BitKeeper by Linux Maintainers
Message-ID: <20020307113246.E20271@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020305165233.A28212@fireball.zosima.org> <20020306095434.B6599@borg.org> <20020306085646.F15303@work.bitmover.com> <20020306221305.GA370@elf.ucw.cz> <a68edn$jjp$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <a68edn$jjp$1@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Mar 07, 2002 at 07:18:15PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The most productive thing people could do might be to just do a BK->CVS
> gateway, if you really feel like it.  Or just go on and ignore the fact
> that some people are using BK - you don't actually have to ever even
> know. 

We've thought of making a readonly CVS pserver interface to BK which would
at least make it easy to get the source in some form that the GPL folks
like.  Somebody else should be able to do that with a perl script.  You
could attempt a read/write interface as well, that's a lot harder, the
impedance mismatch between BK and CVS becomes much more apparent in
the read/write case.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
