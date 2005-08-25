Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbVHYVCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbVHYVCn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 17:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbVHYVCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 17:02:43 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:63709 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751423AbVHYVCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 17:02:42 -0400
Date: Thu, 25 Aug 2005 23:02:01 +0200
From: Sven Schuster <schuster.sven@gmx.de>
To: Harald Welte <laforge@netfilter.org>,
       Alessandro Suardi <alessandro.suardi@gmail.com>, netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netfilter-devel@lists.netfilter.org
Subject: Re: oops in 2.6.13-rc6-git12 in tcp/netfilter routines
Message-ID: <20050825210200.GA10374@zion.homelinux.com>
References: <5a4c581d05082506395fa984ae@mail.gmail.com> <20050825165550.GC4442@rama.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20050825165550.GC4442@rama.de.gnumonks.org>
User-Agent: Mutt/1.5.9i
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:38b5f051b8cd178556c5593940405c4a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi Harald,

On Thu, Aug 25, 2005 at 06:55:50PM +0200, Harald Welte told us:
> Is it true that PeerGuardian is a proprietary application?  I'm not
> going to debug this problem using a proprietary ip_queue program, sorry.

sorry to jump in here, but I took a quick look at PeerGuardian,
according to
http://methlabs.org/wiki/license_information
it's open source.  The source code is available at
http://methlabs.org/projects/peerguardian-linuxosx/

HTH

Sven

--=20
Linux zion.homelinux.com 2.6.13-rc6-mm2 #3 Thu Aug 25 14:53:55 CEST 2005 i6=
86 athlon i386 GNU/Linux
 22:56:18 up  7:40,  1 user,  load average: 0.46, 0.14, 0.04

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDDjHIo4FAdB2PneQRAiX1AJ0Q1heEigmg49MCUMdY9EiDCI9LfwCfVYex
P4mmlStmsdG54dWJxp3u8Ts=
=PEro
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
