Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262228AbVBKHjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbVBKHjw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 02:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbVBKHjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 02:39:20 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:45818 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262218AbVBKHLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 02:11:32 -0500
Date: Fri, 11 Feb 2005 00:11:15 -0700
From: Jeremy Nickurak <atrus@lkml.spam.rifetech.com>
Subject: Re: Logitech MX1000 Horizontal Scrolling
In-reply-to: <20050204195410.GA5279@ucw.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org, Esben Stien <b0ef@esben-stien.name>
Message-id: <1108105875.5676.3.camel@localhost>
MIME-version: 1.0
X-Mailer: Evolution 2.1.3.2
Content-type: multipart/signed; boundary="=-A0xs4hmQ+mtdARrDc2Gd";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <873bxfoq7g.fsf@quasar.esben-stien.name>
 <87zmylaenr.fsf@quasar.esben-stien.name> <20050204195410.GA5279@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-A0xs4hmQ+mtdARrDc2Gd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On ven, 2005-02-04 at 20:54 +0100, Vojtech Pavlik wrote:
> On Thu, Feb 03, 2005 at 03:42:16PM +0100, Esben Stien wrote:
> > Esben Stien <b0ef@esben-stien.name> writes:
> >=20
> > > I got a 12 button logitech MX1000 mouse.=20
> >=20
> > I have still not resolved this issue. Anyone who can point me in any
> > direction?
> =20
> Please try if 2.6.11-rc3 is any better.

Oddly, my horizontal scroll worked fine as extra buttons under 2.6.10.
2.6.11-rc3 causes the scroll wheel to appear under X.org 6.8.1 with the
evdev driver as two seperate mouse buttons being pressed simultaneously.

(Please CC me in replies).


--=-A0xs4hmQ+mtdARrDc2Gd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCDFqTtjFmtbiy5uYRAkdgAJ4lZQHgiew6Fg+4e9LtxcCY0+3jHwCfX+jr
0viIikeyhGphYLv9MKodQi0=
=raZ9
-----END PGP SIGNATURE-----

--=-A0xs4hmQ+mtdARrDc2Gd--
