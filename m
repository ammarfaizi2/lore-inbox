Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262745AbRE0E30>; Sun, 27 May 2001 00:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262746AbRE0E3Q>; Sun, 27 May 2001 00:29:16 -0400
Received: from cpe.atm0-0-0-148189.arcnxx1.customer.tele.dk ([193.89.254.68]:36077
	"HELO serverrummet.dk") by vger.kernel.org with SMTP
	id <S262745AbRE0E3H>; Sun, 27 May 2001 00:29:07 -0400
Date: Sun, 27 May 2001 06:28:45 +0200 (CEST)
From: Rene <kaos@intet.dk>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 + ReiserFS + SMP + umount = oops 
In-Reply-To: <30785.990936705@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.21.0105270625390.22201-100000@virkelig.intet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 May 2001, Keith Owens wrote:

> On Sun, 27 May 2001 06:04:28 +0200 (CEST), 
> Rene <kaos@intet.dk> wrote:
> >hmm I feel quite certain that I am using /dev/tty - is there some way I
> >can check this?
> 
> /etc/inittab, lines for mingetty, getty or agetty.

1:2345:respawn:/sbin/mingetty tty1
.....			      ....	
8:2345:respawn:/sbin/mingetty tty8

is what I have 
default runlevel is 4

regards
  /rene
-- 
Rene Mikkelsen, 
Tlf: +45 40501985
---------------------------------------------------------------
http://www.eslug.dk - the choice of a GNU generation
http://dustpuppy.dk - UF på dansk
---------------------------------------------------------------

