Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVBAIfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVBAIfh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 03:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVBAIfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 03:35:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47331 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261494AbVBAIfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 03:35:30 -0500
Subject: Re: Kernel 2.4.21 hangs up
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: baswaraj kasture <kbaswaraj@yahoo.com>
Cc: inux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050201082001.43454.qmail@web51102.mail.yahoo.com>
References: <20050201082001.43454.qmail@web51102.mail.yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-81++zBIXaURrdVK/V1LD"
Organization: Red Hat, Inc.
Date: Tue, 01 Feb 2005 09:35:22 +0100
Message-Id: <1107246923.4208.53.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-81++zBIXaURrdVK/V1LD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-02-01 at 00:20 -0800, baswaraj kasture wrote:
> Hi,
>=20
> I compiled kernel 2.4.21 with intel compiler .

2.4.21 isn't supposed to be compilable with the intel compiler...

> fine. I am using IA-64 (Intel Itanium 2 ) with EL3.0.

... and the RHEL3 kernel most certainly isn't.

I strongly suggest that you stick to gcc for compiling the RHEL3 kernel.


Also sticking half the world on the CC is considered rude if those
people have nothing to do with the subject at hand, as is the case here.


--=-81++zBIXaURrdVK/V1LD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB/z9Kpv2rCoFn+CIRAgrUAJ95Rb51pZR+qA1Ku14WuUaNkHzjfgCdEe2n
BpmXoRqzYU4fGp3Uq1+/KPM=
=IiUz
-----END PGP SIGNATURE-----

--=-81++zBIXaURrdVK/V1LD--

