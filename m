Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbTIMJIl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 05:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbTIMJIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 05:08:40 -0400
Received: from nan-smtp-09.noos.net ([212.198.2.80]:59511 "EHLO smtp.noos.fr")
	by vger.kernel.org with ESMTP id S262095AbTIMJIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 05:08:39 -0400
Subject: Re: People, not GPL  [was: Re: Driver Model]
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-100N2zFLPDg1V8q/8xWp"
Organization: Adresse personnelle
Message-Id: <1063444117.7962.19.camel@rousalka.dyndns.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Sat, 13 Sep 2003 11:08:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-100N2zFLPDg1V8q/8xWp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

"David Schwartz" wrote :

[ sorry to interupt your flamewar but the amount of nonsence produced
here  starts to irritate me ]

| Who is sending these letters? Who has no respect for the GPL and seeks
| to add additional restrictions?

This is no additional restriction.
Check your history. The linux kernel was always under the GPL, not the
LGPL ie distributing stuff that links with the kernel means this stuff
must be distributed under the gpl.

At some point Linus decreeted linking closed modules was ok with him
(note this was done without consulting anyone, so others contributors
could have objected - they did choose to release stuff under the gpl
after all - but this being Linus they let it pass)

At a later point however the scope of closed linking had grown so big
people started saying enough is enough and GPL-ONLY was born with
Linus's approval.

It is not a licensing change. It's an hint the associated kernel symbols
are not covered by Linus' previous informal exemption and full GPL rules
apply. To avoid rewriting history symbols that could be used in non-free
stuff previously are not GPL-ONLY. People that ignore the hint can and
will be sued (people that link to symbols not GPL-ONLY could be sued too
but everyone seems to have agreed to let it pass). Removing the software
GPL-ONLY checks or working around them has nothing to do with it - it
does not change the basic kernel license nor the stated intentions of
its authors to enforce it. Hiding a do-not-trespass sign does not give
you the right to do it (if you think so do a reality check).

So please stop making horrified noises the GPL is being enforced in a
GPL project. Don't you realise how ridiculous it is ?

--=20
Nicolas Mailhot

--=-100N2zFLPDg1V8q/8xWp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/Yt6VI2bVKDsp8g0RApmAAJ4rgMi9HnlLpEHfznsrvYWaSxemfQCguVUS
3x/i8q+UdWDHMFhI0BOg7Mg=
=/3Xb
-----END PGP SIGNATURE-----

--=-100N2zFLPDg1V8q/8xWp--

