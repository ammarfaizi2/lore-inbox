Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbVLGH30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbVLGH30 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 02:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbVLGH30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 02:29:26 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:7616 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964793AbVLGH3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 02:29:25 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: Johannes Stezenbach <js@linuxtv.org>
Subject: Re: [linux-dvb-maintainer] Re: [PATCH] b2c2: make front-ends selectable and include noob option
Date: Wed, 7 Dec 2005 08:29:24 +0100
User-Agent: KMail/1.9
Cc: Michael Krufky <mkrufky@gmail.com>, linux-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
References: <200512062053.00711.prakash@punnoor.de> <200512062139.16846.prakash@punnoor.de> <20051206215610.GA18247@linuxtv.org>
In-Reply-To: <20051206215610.GA18247@linuxtv.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2880482.or6BiEHnD8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200512070829.29726.prakash@punnoor.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:cec1af1025af73746bdd9be3587eb485
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2880482.or6BiEHnD8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Dienstag Dezember 6 2005 22:56 schrieb Johannes Stezenbach:
> On Tue, Dec 06, 2005, Prakash Punnoor wrote:
> > Well, I said it needed touch up. ;-) After all I didn't seriously belie=
ve
> > it gets merged in current state (and yes, I didn't think about the modu=
le
> > issue, but you're right , of course). But it simply didn't seem like dvb
> > guys are caring about the problem. I once (probably half a year ago
> > already) mailed to linux-dvb and got zero response. That told me
> > everything.
>
> I make it a point to ignore postings which ignore
> the recent mailing list history ;-)
>
> This had been discussed on linux-dvb and the consensus was that
> no one wants to invest time to maintain an #ifdef mess
> just so that people can save a few KB in their kernel.

A short "search the list" note would have been enough, then. I think I=20
followed the list, but probably skipped the messages, as the subject probab=
ly=20
seemed like something else.


> Also, most users don't know and don't care what demodulator
> their card has, the dependency on all of them, plus the
> implied auto probing saves them some headaches and us a lot of
> newbie questions.


Well, could you be so nice and at least turn that xfer transfer errors and=
=20
similar off? I guess that should be debugging output, but only printed when=
=20
you actually want debugging and shouldn't be default behaviour. Does't this=
=20
confuse users? It at least always draws my attention...

bye,
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart2880482.or6BiEHnD8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDlo9ZxU2n/+9+t5gRAlOiAJ9KLGTJKdU5gU79sqEdHIsytwyAjACdHq9f
X58y2yx7HigxNYcJkR4V3tg=
=9OvN
-----END PGP SIGNATURE-----

--nextPart2880482.or6BiEHnD8--
