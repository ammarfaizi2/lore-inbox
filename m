Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266352AbUI0RLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266352AbUI0RLh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 13:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266674AbUI0RLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 13:11:37 -0400
Received: from ctb-mesg1.saix.net ([196.25.240.73]:51374 "EHLO
	ctb-mesg1.saix.net") by vger.kernel.org with ESMTP id S266352AbUI0RLe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 13:11:34 -0400
Subject: Re: [gamin] [RFC][PATCH] inotify 0.10.0 [u]
From: "Martin Schlemmer [c]" <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Robert Love <rml@ximian.com>
Cc: John McCutchan <ttb@tentacle.dhs.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, iggy@gentoo.org
In-Reply-To: <1096302932.30503.27.camel@betsy.boston.ximian.com>
References: <1096250524.18505.2.camel@vertex>
	 <1096302060.11535.54.camel@nosferatu.lan>
	 <1096302248.30503.21.camel@betsy.boston.ximian.com>
	 <1096302649.11535.69.camel@nosferatu.lan>
	 <1096302932.30503.27.camel@betsy.boston.ximian.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-52Z48X9HYeNMigogOikZ"
Date: Mon, 27 Sep 2004 19:10:49 +0200
Message-Id: <1096305049.11535.75.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-52Z48X9HYeNMigogOikZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-09-27 at 12:35 -0400, Robert Love wrote:
> On Mon, 2004-09-27 at 18:30 +0200, Martin Schlemmer [c] wrote:
>=20
> > Right, but using gamin, dnotify+poll support some things that inotify
> > do not support.  Basically the dnotify backend also use the poll backen=
d
> > to enhance it to be able to monitor some events that dnotify by itself
> > cannot (Daniel will be the better person to ask here).  Here is a small
> > snippit from another thread:
>=20
> I am thinking that we have two different definitions of poll here,
> sorry.
>
> I guess you mean poll as in some sort of Gamin backend type?
>=20

Yip.

> Anyhow, I guess this is a Gamin question, not a inotify kernel-side
> question.
>=20

Sorry - we talked about this during last week, and I did not think
to trim the CC list.  I will do so from now on.


Regards,

--=20
Martin Schlemmer

--=-52Z48X9HYeNMigogOikZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBWEmYqburzKaJYLYRAnj8AJ4/A0uA9RWfm1gcGp19QyIeMCPwMgCdFpUv
ovLgaKzNsptS2WzokLSJ4RI=
=8HfD
-----END PGP SIGNATURE-----

--=-52Z48X9HYeNMigogOikZ--

