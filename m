Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbTKNVv1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 16:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264326AbTKNVv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 16:51:27 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:49853 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S262310AbTKNVvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 16:51:25 -0500
Date: Fri, 14 Nov 2003 22:51:23 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031114215123.GB26866@lug-owl.de>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3FB3CB96.9080507@tupshin.com> <Pine.GSO.4.21.0311141051440.2853-100000@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yVhtmJPUSI46BTXb"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0311141051440.2853-100000@waterleaf.sonytel.be>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-11-14 10:56:56 +0100, Geert Uytterhoeven <geert@linux-m68k.org>
wrote in message <Pine.GSO.4.21.0311141051440.2853-100000@waterleaf.sonytel=
=2Ebe>:
> On Thu, 13 Nov 2003, Tupshin Harper wrote:
> > Davide Libenzi wrote:
> > As one of the six, I would happily 2nd the shutting down of the=20
> > pserver...rsync is fine with me. I would actually prefer no CVS archive=
=20
> > at all as long as the raw changesets were rsyncable...then the communit=
y=20
> > would be responsible for doing something useful with them instead of BM.
>=20
> Just wondering: the emails sent to the bk-commits mailing lists are just =
all
> changesets in a `neutral' format that contains all meta information, righ=
t?

These changesets represent what someone "submitted". You can't expect
these to apply cleanly. I've tried once, it will not work.

> So if all individual mails were archived somewhere with correct sequence
> numbers, they could be used to recreate the whole repository in whatever =
format
> you want. I guess it's just a matter of importing them like patches into =
arch.

Nope. You'll have to heal with conflicts first.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--yVhtmJPUSI46BTXb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/tU5bHb1edYOZ4bsRAlu7AJ0VUcIMBpjuLEsSDo5bbtsXJa9flwCdEzYV
rQNPaBvX7IePamCyBZuHOhQ=
=HvN9
-----END PGP SIGNATURE-----

--yVhtmJPUSI46BTXb--
