Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281835AbRLFSHo>; Thu, 6 Dec 2001 13:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281893AbRLFSHf>; Thu, 6 Dec 2001 13:07:35 -0500
Received: from traven.uol.com.br ([200.231.206.184]:13232 "EHLO
	traven.uol.com.br") by vger.kernel.org with ESMTP
	id <S281835AbRLFSHZ>; Thu, 6 Dec 2001 13:07:25 -0500
Date: Thu, 6 Dec 2001 16:06:30 -0200
From: Pablo Borges <pablo.borges@uol.com.br>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.16 & Heavy I/O
Message-Id: <20011206160630.1f4ab058.pablo.borges@uol.com.br>
In-Reply-To: <Pine.LNX.4.30.0112052106450.3740-100000@mustard.heime.net>
In-Reply-To: <20011205175741.124caeff.pablo.borges@uol.com.br>
	<Pine.LNX.4.30.0112052106450.3740-100000@mustard.heime.net>
Organization: UOL Inc
X-Mailer: Sylpheed version 0.6.5claws17 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Don't we have a "dont't eat my whole memory, disk cache" option on linux ?


On Wed, 5 Dec 2001 21:07:42 +0100 (CET)
Roy Sigurd Karlsbakk <roy@karlsbakk.net> wrote:

> > > Absolutely all free memory may be used for disk caching.  So
> > > no, you can't get a bigger cache because it is already at
> > > the highest possible setting.  You don't have more memory
> > > for this - all is used already.
> >
> > May I limit this memory ? For a long time I'm working all day with no
> > physical memory available.
> 
> You can try rtlinux. In rtlinux (realtime linux), you tell linux how
> much memory the kernel will have access to, and let specially written
> apps to take the rest
> --
> Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA
> 
> Computers are like air conditioners.
> They stop working when you open Windows.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
Pablo Borges                                pablo.borges@uol.com.br
-------------------------------------------------------------------
  ____                                               Tecnologia UOL
 /    \    Debian:
 |  =_/      The 100% suck free linux distro.
  \
    \      SETI is lame. http://www.distributed.net
                                                     Dnetc is XNUG!

