Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264054AbUD0NNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264054AbUD0NNE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 09:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264072AbUD0NNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 09:13:04 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:11199 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S264054AbUD0NM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 09:12:59 -0400
Date: Tue, 27 Apr 2004 15:12:57 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license (-> possible GPL violation :)
Message-ID: <20040427131257.GG29503@lug-owl.de>
Mail-Followup-To: Paulo Marques <pmarques@grupopie.com>,
	Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <408DC0E0.7090500@gmx.net> <Pine.LNX.4.58.0404262116510.19703@ppc970.osdl.org> <1083045844.2150.105.camel@bach> <20040427092159.GC29503@lug-owl.de> <408E37D9.7030804@gmx.net> <408E5944.8090807@grupopie.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+sHJum3is6Tsg7/J"
Content-Disposition: inline
In-Reply-To: <408E5944.8090807@grupopie.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+sHJum3is6Tsg7/J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-04-27 13:59:48 +0100, Paulo Marques <pmarques@grupopie.com>
wrote in message <408E5944.8090807@grupopie.com>:
> Carl-Daniel Hailfinger wrote:
> >This way, the module format doesn't change, but we can do additional
> >verification in the loader.
>=20
> The way I see it, they know a C string ends with a '\0'. This is like=20
> saying that a English sentence ends with a dot. If they wrote "GPL\0" the=
y=20
> are effectively saying that the license *is* GPL period.
>=20
> So, where the source code? :)

That's another (quite amusing:) point of view. Anybody willing to ask a
lawyer?

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--+sHJum3is6Tsg7/J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAjlxZHb1edYOZ4bsRAkDpAJwLlI1MEP7yBCTrIGqftyz8YJlTJACeORjG
b8NdcQfuRfIOELAhiyhABBw=
=jP+5
-----END PGP SIGNATURE-----

--+sHJum3is6Tsg7/J--
