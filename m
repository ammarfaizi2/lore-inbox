Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272807AbTHEOyw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 10:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272840AbTHEOyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 10:54:52 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:30383 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S272807AbTHEOyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 10:54:50 -0400
Date: Tue, 5 Aug 2003 16:54:48 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: .config in bzImage ?
Message-ID: <20030805145448.GE1873@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030802192957.GC32488@holomorphy.com> <200308050632.h756W5j17568@Port.imtp.ilyichevsk.odessa.ua> <20030805064528.GR32488@holomorphy.com> <200308051145.h75BjEj19042@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h364vjuHQpf2yNEy"
Content-Disposition: inline
In-Reply-To: <200308051145.h75BjEj19042@Port.imtp.ilyichevsk.odessa.ua>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h364vjuHQpf2yNEy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-08-05 14:54:45 +0300, Denis Vlasenko <vda@port.imtp.ilyichevsk=
=2Eodessa.ua>
wrote in message <200308051145.h75BjEj19042@Port.imtp.ilyichevsk.odessa.ua>:
> On 5 August 2003 09:45, William Lee Irwin III wrote:
> > Insufficient. That's what I do most of the time anyway; when I got
> > burned it was with a batch of kernels I'd built simultaneously.
>=20
> I never build kernels with same names.
> Whenever I change .config, I change extraversion too.

=2E..which implies that you need to do a full recompile. Not nice on slow
machines, or if you haven't got a cross-compiler handy...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--h364vjuHQpf2yNEy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/L8U4Hb1edYOZ4bsRAvojAJ0Wtbl4Rd0DZKnpAEWPVYT/mAyo0ACgjBMs
x0Sm685z98P/2J4urrrXkHE=
=ZWNC
-----END PGP SIGNATURE-----

--h364vjuHQpf2yNEy--
