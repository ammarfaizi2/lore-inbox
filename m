Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262704AbVG3L5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbVG3L5E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 07:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbVG3L5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 07:57:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38846 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263054AbVG3L4e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 07:56:34 -0400
Subject: Re: Slowdown with randomize_va_space in 2.6.12.2
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, pmarques@grupopie.com, davem@davemloft.net,
       davej@redhat.com, Eric Lammerts <eric@lammerts.org>
In-Reply-To: <20050729182029.68748c9f.akpm@osdl.org>
References: <42CBE97C.2060208@grupopie.com>
	 <20050706.125719.08321870.davem@davemloft.net>
	 <20050706205315.GC27630@redhat.com> <20050706181220.3978d7f6.akpm@osdl.org>
	 <1120718229.3198.8.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0507292040530.1819@vivaldi.madbase.net>
	 <20050729182029.68748c9f.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rb2aZYEQHJlQqozZkpQM"
Organization: Red Hat, Inc.
Date: Sat, 30 Jul 2005 07:55:28 -0400
Message-Id: <1122724528.3388.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rb2aZYEQHJlQqozZkpQM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> It has the virtue of simplicity.  Arjan, were you planning on anything
> fancier?

not for 2.6.13; this was the plan
for later I was going to turn it into a bitmask for the individual
randomisations=20

--=-rb2aZYEQHJlQqozZkpQM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC62qwpv2rCoFn+CIRAgudAJ0eXEBhLDdkCLBbGb1DFwyBBs+K6wCcDB9+
P88dBDOaD631lcCAX9FQJUs=
=cDaV
-----END PGP SIGNATURE-----

--=-rb2aZYEQHJlQqozZkpQM--

