Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVDNT4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVDNT4x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 15:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVDNT4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 15:56:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58301 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261369AbVDNT4a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 15:56:30 -0400
Subject: Re: [INFO] Kernel strict versioning
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Sensei <senseiwa@tin.it>
Cc: David Lang <david.lang@digitalinsight.com>,
       Krzysztof Halasa <khc@pm.waw.pl>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <425EC778.4070009@tin.it>
References: <4256C89C.4090207@tin.it> <20050408190500.GF15688@stusta.de>
	 <425B1E3F.5080202@tin.it> <20050412015018.GA3828@stusta.de>
	 <425B3864.8050401@tin.it> <m3mzs4kzdp.fsf@defiant.localdomain>
	 <425C03D6.2070107@tin.it>
	 <Pine.LNX.4.62.0504121053583.17233@qynat.qvtvafvgr.pbz>
	 <425E9FE2.6090102@tin.it>
	 <Pine.LNX.4.62.0504141050460.19663@qynat.qvtvafvgr.pbz>
	 <425EC778.4070009@tin.it>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LrOBg594+Ori9c/IY08C"
Organization: Red Hat, Inc.
Date: Thu, 14 Apr 2005 21:55:13 +0200
Message-Id: <1113508514.6293.82.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LrOBg594+Ori9c/IY08C
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> I'd like API stability, if API stability is=20
> achieved, ABI is there.

this is a joke right? If you really think this you have no idea what ABI
stability means and how extremely hard it is to even sort of remotely
approach it.

Trust me. It's *extremely* hard to impossible. Several security fixes
can only be fixed this way. And it's REALLY fragile even if for other
fixes. And I am very glad that the linux kernel people in general decide
to not go for abi stability, the hacks that would be needed would be so
obscene and the gains very very minimal. (it's open source, you have the
source after all!)


--=-LrOBg594+Ori9c/IY08C
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCXsqhpv2rCoFn+CIRAu42AJ9hDLzHjCyEwD9YJmZg+/u2zm1oDgCfZ6Ge
Ttgl4PgwwGYiaFAIXSOc8M0=
=bjWb
-----END PGP SIGNATURE-----

--=-LrOBg594+Ori9c/IY08C--

