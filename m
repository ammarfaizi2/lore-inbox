Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261587AbSKRHUL>; Mon, 18 Nov 2002 02:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261593AbSKRHUK>; Mon, 18 Nov 2002 02:20:10 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:23312 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S261587AbSKRHUJ>;
	Mon, 18 Nov 2002 02:20:09 -0500
Date: Mon, 18 Nov 2002 08:27:09 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: lan based kgdb
Message-ID: <20021118072709.GT4545@lug-owl.de>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021116182454.GH19061@waste.org> <Pine.LNX.4.44.0211161025500.15838-100000@home.transmeta.com> <20021117095632.GN4545@lug-owl.de> <1037544804.4334.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0WGqsT62A4RTsSXf"
Content-Disposition: inline
In-Reply-To: <1037544804.4334.21.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
x-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
x-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0WGqsT62A4RTsSXf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2002-11-17 14:50:32 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk>
wrote in message <1037544804.4334.21.camel@irongate.swansea.linux.org.uk>:
> On Sun, 2002-11-17 at 09:56, Jan-Benedict Glaw wrote:
> > ...which reminds me to DEC's MOP (Maintainence and Operator's Protocol),
> > which is ethernet (but not IP) based remote console and a mixture of
> > bootp/tftp. Sure, we won't (yet) go as far as sending the next kernel to
> > boot via our new console protocol to kexec(), but wait for the very
> > first S-Records to arrive:-p
>=20
> We have working DECnet and MOP server protocol support. That doesn't
> mean its a good idea

Really? Do we? Well, sure for the server part (-> booting. Half a dozend
implementations from which only one ot possibly two are really useable),
but the client side (remote console) was never implemented IIRC. And for
sure there's no MOP console server on linux:-)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet!
   Shell Script APT-Proxy: http://lug-owl.de/~jbglaw/software/ap2/

--0WGqsT62A4RTsSXf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD4DBQE92JZNHb1edYOZ4bsRAqF1AJdNzmqENwtS9b0b7Z8IQzhBPo+mAKCLIYlS
jvxh5jFWTDiAb/F5roQA6g==
=fhBj
-----END PGP SIGNATURE-----

--0WGqsT62A4RTsSXf--
