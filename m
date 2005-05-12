Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbVELU0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbVELU0h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 16:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVELU0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 16:26:37 -0400
Received: from lug-owl.de ([195.71.106.12]:23501 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S262065AbVELU0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 16:26:34 -0400
Date: Thu, 12 May 2005 22:26:33 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Alan Bryan <icemanind@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Enhanced Keyboard Driver
Message-ID: <20050512202633.GE8176@lug-owl.de>
Mail-Followup-To: Alan Bryan <icemanind@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20050512193917.GC8176@lug-owl.de> <20050512194805.52183.qmail@web53101.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dOtxUVmLoGkyu1PA"
Content-Disposition: inline
In-Reply-To: <20050512194805.52183.qmail@web53101.mail.yahoo.com>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dOtxUVmLoGkyu1PA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-05-12 12:48:05 -0700, Alan Bryan <icemanind@yahoo.com> wrote:
> > What do you actually want to do?

> The part I'm having trouble with though is having it
> popup when predetermined keystrokes are pushed. I
> don't think Linux has a way to hook into the keyboard
> (if I'm wrong, someone please tell me).

Well, this sounds more like a userspace problem. Write a small app that
select()s on /dev/input/event* and get the keystrokes from there. From
there, you'd even start applikations. That's a lot more complicated to
achieve in kernel space :-)

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--dOtxUVmLoGkyu1PA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCg7v5Hb1edYOZ4bsRAhhXAJ0aK78CiPdDO5Xcq05ZqwdPeEV58ACfRXnq
AU5UKawThW/g98TRvNgHG7Y=
=x2Hg
-----END PGP SIGNATURE-----

--dOtxUVmLoGkyu1PA--
