Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270013AbTHJQzb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 12:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270022AbTHJQzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 12:55:31 -0400
Received: from starcraft.mweb.co.za ([196.2.45.78]:45518 "EHLO
	starcraft.mweb.co.za") by vger.kernel.org with ESMTP
	id S270013AbTHJQza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 12:55:30 -0400
Subject: Re: [2.6] Oops's on running javac
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Andrew Morton <akpm@osdl.org>
Cc: KML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030809184252.57c07482.akpm@osdl.org>
References: <1060478155.8610.9.camel@nosferatu.lan>
	 <20030809184252.57c07482.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Jqx5XmyliFI0UD9i/uFh"
Message-Id: <1060534563.11013.24.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 10 Aug 2003 18:56:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Jqx5XmyliFI0UD9i/uFh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-08-10 at 03:42, Andrew Morton wrote:
> Martin Schlemmer <azarah@gentoo.org> wrote:
> >
> > Been getting this with the last couple of kernels.
>=20
> I have some fixes which might address this.  Please
> test test3-mm1 when I get around to releasing it, later
> today?

For the record, the zap_other_threads-fix.patch from
test3-mm1 fixes this issue - thanks Andrew for pointing
it out!


Regards,

--=20

Martin Schlemmer




--=-Jqx5XmyliFI0UD9i/uFh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/NnkjqburzKaJYLYRAsXPAJ9LELzbFt96s5ZFm8B++2oqdMd3cQCff4E7
RZ/Dq+UP/OBlKLiiG3cTSis=
=lC8K
-----END PGP SIGNATURE-----

--=-Jqx5XmyliFI0UD9i/uFh--

