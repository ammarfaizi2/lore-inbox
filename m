Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269090AbUIHKO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269090AbUIHKO6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 06:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269091AbUIHKO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 06:14:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26269 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269090AbUIHKO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 06:14:56 -0400
Subject: Re: [patch] to add device+inode check to ipt_owner.c - HACKED UP
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040908100946.GA9795@lkcl.net>
References: <20040908100946.GA9795@lkcl.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PuojXLU0AbLCZUsSkziM"
Organization: Red Hat UK
Message-Id: <1094638489.2800.7.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 08 Sep 2004 12:14:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PuojXLU0AbLCZUsSkziM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-09-08 at 12:09, Luke Kenneth Casson Leighton wrote:
> dear kernel people,
>=20
> this is a first pass at attempting to add per-program firewall rule
> checking to iptables.

question: any reason you didn't use something like selinux-like contexts
instead of dentry/device pairs ?=20

--=-PuojXLU0AbLCZUsSkziM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBPtuZxULwo51rQBIRAr9eAJ0YwzhWKEIzvAkCjiPHaLnMwrIq7wCghqMp
gh6y/sss4JEfWvDbrsW7J4k=
=0C+T
-----END PGP SIGNATURE-----

--=-PuojXLU0AbLCZUsSkziM--

