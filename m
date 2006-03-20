Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbWCTUTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWCTUTL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 15:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbWCTUTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 15:19:11 -0500
Received: from lug-owl.de ([195.71.106.12]:49376 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1030214AbWCTUTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 15:19:10 -0500
Date: Mon, 20 Mar 2006 21:19:05 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, klibc@zytor.com,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: Merge strategy for klibc
Message-ID: <20060320201905.GI20746@lug-owl.de>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	klibc@zytor.com, torvalds@osdl.org, akpm@osdl.org
References: <441F0859.2010703@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iTgyUaBDSpHJk5wi"
Content-Disposition: inline
In-Reply-To: <441F0859.2010703@zytor.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--iTgyUaBDSpHJk5wi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-03-20 11:54:01 -0800, H. Peter Anvin <hpa@zytor.com> wrote:
> a. There are several architectures which don't have klibc ports yet.
>    Since I don't have access to them, I can't really do them, either.
>    It's usually a matter of an afternoon or less to port klibc to a
>    new architecture, though, if you have a working development
>    environment for it.

I haven't yet looked at your code, but what actually needs to be done?
Defining syscall macros?

I'd probably give it a try for VAX.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--iTgyUaBDSpHJk5wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEHw45Hb1edYOZ4bsRAlYpAKCJyoq7jzkcCF4eA/Vtqm7mRZS/KACfamu/
OdXBPNbzsIK7ijaDXaLecuM=
=jvoN
-----END PGP SIGNATURE-----

--iTgyUaBDSpHJk5wi--
