Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292918AbSCIUzr>; Sat, 9 Mar 2002 15:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292919AbSCIUzh>; Sat, 9 Mar 2002 15:55:37 -0500
Received: from lsanca1-ar27-4-63-184-089.lsanca1.vz.dsl.gtei.net ([4.63.184.89]:55708
	"EHLO barbarella.hawaga.org.uk") by vger.kernel.org with ESMTP
	id <S292918AbSCIUzd>; Sat, 9 Mar 2002 15:55:33 -0500
Date: Sat, 9 Mar 2002 12:55:21 -0800 (PST)
From: Ben Clifford <benc@hawaga.org.uk>
To: Jos Hulzink <josh@stack.nl>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.5.6: IPv6 fails to initialize
In-Reply-To: <20020309104503.I12051-100000@snail.stack.nl>
Message-ID: <Pine.LNX.4.33.0203091253450.23831-100000@barbarella.hawaga.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sat, 9 Mar 2002, Jos Hulzink wrote:

> 2.5.6 comes with the next error:
>
> Failed to initialize the ICMP6 control socket (err -97).
>
> I have not found any kernel settings that affect this error, it happens
> both with IPv6 compiled in kernel and loaded as module.

There was a similar problem with the -dj tree a while ago - I think the
solution is probably the same.

Search the archives for the thread titled:

Subject: Linux 2.5.5-dj1 - IPv6 not loading correctly.


- -- 
Ben Clifford     benc@hawaga.org.uk     GPG: 30F06950
http://www.hawaga.org.uk/ben/

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8ina8sYXoezDwaVARAl5lAJ4wj6izPK+UhM12uz2axTxLbbVcrACfTEpQ
WdCoZrOWKvWDHWqNI06w+sE=
=dmRK
-----END PGP SIGNATURE-----

