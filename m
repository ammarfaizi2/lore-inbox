Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262012AbTCHNhl>; Sat, 8 Mar 2003 08:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262013AbTCHNhl>; Sat, 8 Mar 2003 08:37:41 -0500
Received: from mx.laposte.net ([213.30.181.11]:25499 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id <S262012AbTCHNhk>;
	Sat, 8 Mar 2003 08:37:40 -0500
Subject: Re: 2.5.64p5 No USB support when APIC mode enabled
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: Meino Christian Cramer <mccramer@s.netic.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030308.132939.75185771.mccramer@s.netic.de>
References: <1047063457.1947.2.camel@rousalka>
	 <20030308.132939.75185771.mccramer@s.netic.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xa556gdv0OFJZ29iDmZ2"
Organization: 
Message-Id: <1047131289.3544.14.camel@rousalka>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 08 Mar 2003 14:48:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xa556gdv0OFJZ29iDmZ2
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Le sam 08/03/2003 =E0 13:29, Meino Christian Cramer a =E9crit :
> From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
> Subject: Re: 2.5.64p5 No USB support when APIC mode enabled
> Date: 07 Mar 2003 19:57:37 +0100
>=20
> Hi Nicolas.
>=20
>  ..._I_ am the stupid one, Nicolas :)
>=20
>  Could you pleas e give me a short hint, how I should handle
>  what I have found (USB probs) with the bugzilla interface.
>  Haven't used it before...

Bugzilla is very user-unfriendly at first but one get used to it and
it's very powerful (plus lots of projects use it)

Usually when you have found a problem you should :

1. Search if it's not already reported (query, usually search by
summary/description gets the broadest results)

2. If you find a bug that looks the same :
* add yourself to the CC list
* add a comment stating your problem and why you think it's the same

If it's not the same problem the maintainer which knows best will tell
you to open another bug (so if you're not sure, ask about it in your
comment)

3. if you didn't find any similar problem open a new bug. The important
parts are
* Fill it in the best category so it will be directed to the good person
* Use a =AB catchy =BB summary which makes clear what the problem is
* Attach relevant files (often dmesg, kernel config, lspci)
* Only specify the person to whom the bug should be assigned if you're
sure of what you're doing (ie this person is already treating similar
bugs) ! Bad assignment will loose time and annoy people, and bugzilla
will try to select the right maintainer based on the category you've
chosen if you leave the field blank.

Note bugzilla is very flexible ; if you made mistakes the bug will be
reclassified/redirected till it's filled correctly (however this will
take time)

Moreover note bugzilla usage for the kernel is fairly recent. Some
maintainers are still not used to it, so they'll also make mistakes.

Last hint : all bugzilla fields are commented, usually a link right next
to each field will lead to an explanation.

Regards,

--=20
Nicolas Mailhot

--=-xa556gdv0OFJZ29iDmZ2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+afSZI2bVKDsp8g0RAoJLAKCjdJENNdKgP2wr2leCteumnaX5FgCggdap
Fkrx6nrdOKxWrtIxzULzKgM=
=RXXB
-----END PGP SIGNATURE-----

--=-xa556gdv0OFJZ29iDmZ2--

