Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264342AbUAOOf5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 09:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbUAOOf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 09:35:57 -0500
Received: from hostmaster.org ([80.110.173.103]:898 "HELO hostmaster.org")
	by vger.kernel.org with SMTP id S264342AbUAOOfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 09:35:54 -0500
Subject: Re: 2.4.24 SMP lockups
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58L.0401141420090.14071@logos.cnet>
References: <Pine.LNX.4.58L.0401101758010.1310@logos.cnet>
	 <20040111090135.GB6834@netnation.com>
	 <Pine.LNX.4.58L.0401141420090.14071@logos.cnet>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SnY4okRmj2Qfm1XZ3iF2"
Message-Id: <1074177341.1394.11.camel@hostmaster.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Thu, 15 Jan 2004 15:35:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SnY4okRmj2Qfm1XZ3iF2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Marcelo,

as I have posted before I do also have a SMP lockup problem with
2.6.0/2.6.1 and the de4x5 driver that still keeps me from using any of
the 2.6 kernel series. I have already created a bug report for this
including the NMI watchdog oops message:
http://bugme.osdl.org/show_bug.cgi?id=3D1855

Tom

--=20
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
       mail pgp-key-request@hostmaster.org

UNIX is user-friendly ... it's just selective about who it's friends are

--=-SnY4okRmj2Qfm1XZ3iF2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQEVAwUAQAalN2D1OYqW/8uJAQLpZQf+On4SIUMNsqWDOtqB+QyIVCOWi3RpM44D
0hv6cWdbIlUFw878NJyxtR8Ix2eiZ3YhhqtDYg1MX1nLVbv72EJsVHeQzW94woEa
GdJ28xgytjUfBGEfTJ8m4fRJ0ZdjfF+VFb+XNDZ2qrAnWCsh9hC5RiRN4EpBZaI3
DxR6xulVxBm9oto+2UbB8VuA5H0UaeDZq7l2ftA58DqZtI97anS4XcEobrmXap2R
DBUzNrOqqU+l6uDvdtgRv06+doNKwXqfeq4ayylL+Z7zPpNwlZSws/gXeKAGOJ1z
TUD+JdMoYZ6O2BiTdzfcaIJ7gHqqg6vlzpbadsE5TyQlTtJrcHoinQ==
=U1Nx
-----END PGP SIGNATURE-----

--=-SnY4okRmj2Qfm1XZ3iF2--

