Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269103AbUJQMSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269103AbUJQMSh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 08:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269105AbUJQMSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 08:18:35 -0400
Received: from lug-owl.de ([195.71.106.12]:158 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S269103AbUJQMSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 08:18:32 -0400
Date: Sun, 17 Oct 2004 14:18:31 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: I/O card vs linux
Message-ID: <20041017121831.GH5033@lug-owl.de>
Mail-Followup-To: Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200410160423.43597.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fe0dstq7l4iXK2TV"
Content-Disposition: inline
In-Reply-To: <200410160423.43597.gene.heskett@verizon.net>
X-Operating-System: Linux mail 2.6.8-rc4 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Fe0dstq7l4iXK2TV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-10-16 04:23:43 -0400, Gene Heskett <gene.heskett@verizon.net>
wrote in message <200410160423.43597.gene.heskett@verizon.net>:
> Greetings;
>=20
> This may be OT, but can anyone advise me on a pci card thats basicly=20
> an 8255 with a 34 pin or greater port on the card or back panel to=20
> bring out all 3 ports, and a suitable linux compatible driver for it?

For input? Output? Both? In the output-only with low "bandwith" being
okay, just think about attaching a number of serial-in-parallel-out
shift registers to your parport. I use something like that for switching
on and off computers...

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Irak! =
  O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--Fe0dstq7l4iXK2TV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBcmMXHb1edYOZ4bsRApVsAJ0ccdBHfyz8pnGymaCn8Uh/RLPgWgCeJpjl
HLf6XpVNNeFx4D1Asto432k=
=ilgT
-----END PGP SIGNATURE-----

--Fe0dstq7l4iXK2TV--
