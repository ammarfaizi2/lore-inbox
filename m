Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUDNOiL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 10:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263415AbUDNOiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 10:38:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47256 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261347AbUDNOiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 10:38:08 -0400
Subject: Re: Shielded CPUs
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: "Calin A. Culianu" <calin@ajvar.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0404141013330.20579-100000@rtlab.med.cornell.edu>
References: <Pine.LNX.4.33L2.0404141013330.20579-100000@rtlab.med.cornell.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-puIjSx4xY6g47QicUbx4"
Organization: Red Hat UK
Message-Id: <1081953482.11976.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 14 Apr 2004 16:38:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-puIjSx4xY6g47QicUbx4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-04-14 at 16:23, Calin A. Culianu wrote:
> This might be a bit off-topic (and might belong in the rtlinux mailing
> list), but I wanted people's opinion on LKML...
>=20
> There's an article in the May 2004 Linux Journal about some CPU affinity
> features in Redhawk Linux that allow a process and a set of interrupts to
> be locked to a particular CPU for the purposes of improving real-time
> performance.

well you can do both of those already in 2.6 and in all recent vendor
2.4's that I know of..... no patches needed.


--=-puIjSx4xY6g47QicUbx4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAfUzJxULwo51rQBIRAnqfAJ0avZux+aAp55jIuL+O+5Xlj5MUXACgjx4m
HSqSphXvw1SiVhliWGFXM5M=
=KY7O
-----END PGP SIGNATURE-----

--=-puIjSx4xY6g47QicUbx4--

