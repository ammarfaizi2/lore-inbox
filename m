Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132690AbRDOPwT>; Sun, 15 Apr 2001 11:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132691AbRDOPwK>; Sun, 15 Apr 2001 11:52:10 -0400
Received: from ppp100-yorkpa.netrax.net ([205.231.165.100]:38929 "EHLO
	yinyang.hjsoft.com") by vger.kernel.org with ESMTP
	id <S132690AbRDOPvy>; Sun, 15 Apr 2001 11:51:54 -0400
Date: Sun, 15 Apr 2001 11:55:49 -0400 (EDT)
From: "Mr. Shannon Aldinger" <god@yinyang.hjsoft.com>
Reply-To: <god@yinyang.hjsoft.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: "uname -p" prints unknown for Athlon K7 optimized kernel?
In-Reply-To: <20010415155706.A188@elfie>
Message-ID: <Pine.LNX.4.31.0104151152400.26676-100000@yinyang.hjsoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sun, 15 Apr 2001, it was written:

> elfie:~ # uname -p
> unknown
>
> elfie:~ # uname -a
> Linux elfie 2.4.3 #1 Fri Apr 13 21:08:29 CEST 2001 i586 unknown
>
I get the same on my Sun Ultra 1, and various x86 boxes. I'm sure this is
normal, I'm just not sure how you would change that label. I know gcc
compiles everything with a target of gcc-linux-unkown on my machines, so
the uknown may be coming from there...
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Made with pgp4pine 1.75

iEYEARECAAYFAjrZxI0ACgkQwtU6L/A4vVCO6wCdGoot4MMYmrdW4N2ankreoHXn
t1UAoJLpUTlsEY+jQCcSrz6ezId2oUqM
=sCuV
-----END PGP SIGNATURE-----


