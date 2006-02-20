Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWBTKGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWBTKGZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 05:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWBTKGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 05:06:24 -0500
Received: from multi.science.ru.nl ([131.174.16.159]:19609 "EHLO
	multi.science.ru.nl") by vger.kernel.org with ESMTP id S964823AbWBTKGY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 05:06:24 -0500
From: Sebastian =?iso-8859-15?q?K=FCgler?= <sebas@kde.org>
To: Matthias Hensler <matthias@wspse.de>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Mon, 20 Feb 2006 11:05:34 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>,
       nigel@suspend2.net, rjw@sisk.pl, suspend2-devel@lists.suspend2.net
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060218142610.GT3490@openzaurus.ucw.cz> <20060220093911.GB19293@kobayashi-maru.wspse.de>
In-Reply-To: <20060220093911.GB19293@kobayashi-maru.wspse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3400338.lA2512bLnK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602201105.35378.sebas@kde.org>
X-Spam-Score: -1.665 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3400338.lA2512bLnK
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 20 February 2006 10:39, Matthias Hensler wrote:
> > > The only con I see is the complexity of the code, but then again,
> > > Nigel
> >
> > ..but thats a big con.
>
> So why is that? From what I see, most of the code is completly independ
> of the rest of the kernel, and just does not affect if it is disabled.
>
> It won't do any harm to the kernel, and again, Nigel is constantly
> improving that situation, so for sure, that is no _big_ con.

I might add that you'd drag a devoted developer into the kernel team more=20
closely, which probably makes up for the 'added complexity' anyway.

The gain in working *together* on suspend2 is worth much more than the 'add=
ed=20
complexity' Pavel complains about. Nigel has stated more than once that he'=
d=20
be happy to maintain suspend2, and he's done so for quite some time already=
,=20
which proves his point. Nigel is paid to work on suspend2, so it's not like=
ly=20
to go away once he has a new hobby (and again, he's been doing great work f=
or=20
some time already).=20

So what about working on merging suspend2 finally? Having a proven, stable =
and=20
feature-rich implemenation available quickly, *and* someone who maintains=20
*and* support it actively does not sound like a bad deal to me.

One should not underestimate the gains that a suspend2 merge has on the=20
development merely by stating 'added complexity', that pays off _any_day_.

By the way, does 'working on uswsusp' mean that Pavel and will put less wor=
k=20
in maintaining swsusp? That does not sound too promising to my sore ears.

Personally, to work with, I'd prefer a developer who's responsibly dealing=
=20
with users' questions and problems any day to one who rejects 99% of emails=
=20
that don't contain a patch and 95% of those that contain one, stating 'WTF,=
 I=20
don't like that'.

Bottom line: Judging developer resources only by lines of code added does n=
ot=20
make too much sense.
=2D-=20
sebas

 http://www.kde.org | http://vizZzion.org |  GPG Key ID: 9119 0EF9=20
=2D - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -=
 -
Accident, n.:	A condition in which presence of mind is good, but absence of=
=20
body is better.  - Foolish Dictionary


--nextPart3400338.lA2512bLnK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQEVAwUAQ/mUb2dNh9WRGQ75AQI0swgA2qN2rIXqZJiVfgTjx0EVG5QEjGZmerUa
bJUByBc5Wfptox6ry2jWDOFnJxthYFh7huv6XdGALgUueEzb7DHuj12SM7i+zl7s
lan3yJBu6rSKxNzBWgGIgLD73dxNmfOF/Ur9fp/VVTOk7vOEt1rOvZxDQMAKkhR4
MQWM7uPTtf+SIRI5BujdAB5iWTUXcBwxC/QisVqdPlwmre8ra+0UD855y6Uzpwet
AFzFRS/iKQzbCpO1ZyRB+OVbwrZ8Rp7uLNRlQVoOTHkl0cMpoSwOOf/L3KPiywhR
jZaa1Gt3kbY22o1Wj6i3WriPiSN8yBIe5bYNN3MQaXPeVxHtOtuwWw==
=758N
-----END PGP SIGNATURE-----

--nextPart3400338.lA2512bLnK--
