Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289056AbSBJAhl>; Sat, 9 Feb 2002 19:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289057AbSBJAhW>; Sat, 9 Feb 2002 19:37:22 -0500
Received: from eriador.apana.org.au ([203.14.152.116]:43274 "EHLO
	eriador.apana.org.au") by vger.kernel.org with ESMTP
	id <S289056AbSBJAhK>; Sat, 9 Feb 2002 19:37:10 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: lm@bitmover.com (Larry McVoy), linux-kernel@vger.kernel.org
Subject: Re: pull vs push (was Re: [bk patch] Make cardbus compile in -pre4)
In-Reply-To: <20020209122649.E13735@work.bitmover.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.17-686-smp (i686))
Message-Id: <E16ZhzF-0000ST-00@gondolin.me.apana.org.au>
Date: Sun, 10 Feb 2002 11:36:57 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> wrote:

> This is my problem.  You could help if you could tell me what exactly 
> are the magic wands to wave such that you can ssh in without typing
> a password.  I know about ssh-agent but that doesn't help for this, 

Setup your key with an empty passphrase should do the trick.
-- 
Debian GNU/Linux 2.2 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
