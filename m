Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbUKCBpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbUKCBpq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 20:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbUKCBpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 20:45:46 -0500
Received: from ctb-mesg6.saix.net ([196.25.240.78]:23210 "EHLO
	ctb-mesg6.saix.net") by vger.kernel.org with ESMTP id S261311AbUKCBpe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 20:45:34 -0500
Subject: Re: XMMS (or some other audio player) 'hang' issues with intel8x0
	and	dmix plugin [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>, alsa-user@lists.sourceforge.net
In-Reply-To: <41873A9E.3020909@tequila.co.jp>
References: <1099284142.11924.17.camel@nosferatu.lan>
	 <41873A9E.3020909@tequila.co.jp>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xPmEzQrIJDvh3vi2aU7Y"
Date: Wed, 03 Nov 2004 03:45:18 +0200
Message-Id: <1099446318.11924.23.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xPmEzQrIJDvh3vi2aU7Y
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-11-02 at 16:43 +0900, Clemens Schwaighofer wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> On 11/01/2004 01:42 PM, Martin Schlemmer [c] wrote:

> | Now I mostly use XMMS for playing mp3's, and intermittently xmms
> | will just 'hang'.  It is not locked or anything, but the 'graph'
> | just stand still, and no audio.  If I press play again, it starts
> | to play for some time again.  This is especially easy to duplicate
> | if the box is under heavy load.  If I use the device directly,
> | without the dmix plugin, it works fine, or if I use oss emulation,
> | it works fine as well ...
>=20
> I have the same problem at home, I changed something in the .asoundrc
> and it went away. it still plays a little bit skippy, but better than
> suddenly stop.
>=20
> I had this problem on a Sony Laptop (GRX series) with an i8x0 chipsetz
> and a yamaha soundchip (which is controlled by the i8x0 drivers).
>=20
> I can give more info if needed.
>=20

I would appreciate that.  Any workaround currently will be nice.


Thanks,

--=20
Martin Schlemmer


--=-xPmEzQrIJDvh3vi2aU7Y
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBiDguqburzKaJYLYRAh2PAJ45qKni48ZIdeutTxvvIQUhZfdIggCggNW3
Yjks4dhl+D9NkWvTuSRpdlM=
=WAbO
-----END PGP SIGNATURE-----

--=-xPmEzQrIJDvh3vi2aU7Y--

