Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262741AbRE0EFQ>; Sun, 27 May 2001 00:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262738AbRE0EFG>; Sun, 27 May 2001 00:05:06 -0400
Received: from cpe.atm0-0-0-148189.arcnxx1.customer.tele.dk ([193.89.254.68]:28909
	"HELO serverrummet.dk") by vger.kernel.org with SMTP
	id <S262741AbRE0EEs>; Sun, 27 May 2001 00:04:48 -0400
Date: Sun, 27 May 2001 06:04:28 +0200 (CEST)
From: Rene <kaos@intet.dk>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 + ReiserFS + SMP + umount = oops 
In-Reply-To: <30469.990935071@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.21.0105270600300.21127-100000@virkelig.intet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 27 May 2001 05:10:30 +0200 (CEST), 
> Rene <kaos@intet.dk> wrote:
> >Problem #2
> >Certain keystrokes like ctrl+c does not work when logged in from the
> >console
> 
> Are you using /dev/console or /dev/tty for the console session?
> /dev/console does not support control-C, use /dev/tty for a VGA
> session, /dev/ttyS<n> for a serial line.

hmm I feel quite certain that I am using /dev/tty - is there some way I
can check this? The setup on this machine wrt login shouldn't be any
different from what I use on my other boxes, and there I have no problem
with stuff like ctrl+c 

regards
/rene

-- 
Rene Mikkelsen, 
Tlf: +45 40501985
---------------------------------------------------------------
http://www.eslug.dk - the choice of a GNU generation
http://dustpuppy.dk - UF på dansk
---------------------------------------------------------------

