Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270228AbTGMLkd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 07:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270229AbTGMLkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 07:40:33 -0400
Received: from mailg.telia.com ([194.22.194.26]:20182 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id S270228AbTGMLkb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 07:40:31 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] SCHED_ISO for interactivity
From: Christian Axelsson <smiler@lanil.mine.nu>
Reply-To: smiler@lanil.mine.nu
To: Guillaume Chazarain <gfc@altern.org>
Cc: linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>,
       phillips@arcor.de
In-Reply-To: <SO8752FA8VR71YW8IEQOJDXT3Y86D8.3f113765@monpc>
References: <SO8752FA8VR71YW8IEQOJDXT3Y86D8.3f113765@monpc>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sX7hBcU3TvAIqkjrWT+X"
Organization: LANIL
Message-Id: <1058097290.12248.40.camel@sm-wks1.lan.irkk.nu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 13 Jul 2003 13:54:52 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sX7hBcU3TvAIqkjrWT+X
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-07-13 at 12:41, Guillaume Chazarain wrote:
> Hi Con,
>=20
> I am currently testing SCHED_ISO, but I have noticed a regression:
> I do a make -j5 in linux-2.5.75/ everything is OK since gcc prio is 25.
> X and fvwm prio are 15, but when I move a window it's very jerky.

It's pretty smooth on my desktop (t-bird 1.4, 512mb ram, nvidia)

> BTW2, you all seem to test interactivity with xmms. Just for those like m=
e
> that didn't noticed, I have just found that it skips much less with alsa'=
s
> OSS emulation than with alsa-xmms.

I will try that out, seems to work so far, intressting...

--=20
Christian Axelsson
smiler@lanil.mine.nu

--=-sX7hBcU3TvAIqkjrWT+X
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/EUiJyqbmAWw8VdkRAp60AKCJlcbcjAsKJoeV35JKSJ0VhdcIlACggI7h
cWRD0F+sAktt737VN0gNOvY=
=UMpX
-----END PGP SIGNATURE-----

--=-sX7hBcU3TvAIqkjrWT+X--

