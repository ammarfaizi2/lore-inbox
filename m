Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267544AbTACOzo>; Fri, 3 Jan 2003 09:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267543AbTACOzn>; Fri, 3 Jan 2003 09:55:43 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:13807 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S267541AbTACOzl>; Fri, 3 Jan 2003 09:55:41 -0500
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Paul Jakma <paulj@alphyra.ie>
Cc: Richard Stallman <rms@gnu.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0301031449390.32195-100000@dunlop.admin.ie.alphyra.com>
References: <Pine.LNX.4.44.0301031449390.32195-100000@dunlop.admin.ie.alphyra.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7PJuMki4EQ+UJ7DDopSm"
Organization: Red Hat, Inc.
Message-Id: <1041606221.1337.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 03 Jan 2003 16:03:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7PJuMki4EQ+UJ7DDopSm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-01-03 at 15:52, Paul Jakma wrote:


> Indeed, so why not add an exemption into the kernel's licence for=20
> binary only modules that only use module exported interfaces? The=20
> FSF's FAQ on the GPL even covers this.

unfortionatly that's impossible.
First of all *all* copyright holders of the kernel would need to agree
to it. Second, it would make it impossible for the kernel to just
incorporate other GPL code (like we do all the time, including FSF code)

--=-7PJuMki4EQ+UJ7DDopSm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+FaZNxULwo51rQBIRAmgZAJ9KRLgggVEt1ugCqR2eTVJTUV9/+gCfZ1qD
spSrlYBDspakeXI8fvS2Zqc=
=bMrY
-----END PGP SIGNATURE-----

--=-7PJuMki4EQ+UJ7DDopSm--
