Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316705AbSE0RvZ>; Mon, 27 May 2002 13:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316717AbSE0RvY>; Mon, 27 May 2002 13:51:24 -0400
Received: from squeaker.ratbox.org ([63.216.218.7]:21267 "EHLO
	squeaker.ratbox.org") by vger.kernel.org with ESMTP
	id <S316705AbSE0RvX> convert rfc822-to-8bit; Mon, 27 May 2002 13:51:23 -0400
Date: Mon, 27 May 2002 13:51:20 -0400 (EDT)
From: Aaron Sethman <androsyn@ratbox.org>
To: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RT Sigio broken on 2.4.19-pre8
In-Reply-To: <3CF1ED6D.1030202@loewe-komp.de>
Message-ID: <Pine.LNX.4.44.0205271350300.3998-100000@simon.ratbox.org>
X-GPG-FINGRPRINT: 1024D/D4DE2553 0E60 59B5 60DA 2FD3 F6F5  27A3 6CD2 21AD D4DE 2553
X-GPG-PUBLIC_KEY: http://squeaker.ratbox.org/androsyn.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

http://www.kegel.com/dkftpbench/

Its part of dkftpbench.

Regards,

Aaron

On Mon, 27 May 2002, Peter Wächtler wrote:

> Aaron Sethman wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> >
> > Using the Dan Kegel's Poller_bench utility I noticed that RT SIGIO is not
> > working on 2.4.19-pre8.  Basically sigtimedwait() is always returning
> > SIGIO.  Note that 2.4.18 works fine.
> >
>
> What is this Poller_bench and where do I get it?
>
>
>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE88nIabNIhrdTeJVMRArg+AKC2Tgc56ua7W1UkQpPPBjMLimcWswCeIb1W
41rOcPf1uliWmdrTPBq5j2k=
=WxjP
-----END PGP SIGNATURE-----

