Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267461AbUHJPZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267461AbUHJPZN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 11:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267468AbUHJPZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 11:25:13 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:38784 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S267461AbUHJPZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 11:25:00 -0400
Date: Tue, 10 Aug 2004 17:24:59 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, alan@lxorguk.ukuu.org.uk,
       axboe@suse.de, diablod3@gmail.com, dwmw2@infradead.org,
       eric@lammerts.org, james.bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040810152458.GA1127@lug-owl.de>
Mail-Followup-To: Stephan von Krawczynski <skraw@ithnet.com>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>,
	alan@lxorguk.ukuu.org.uk, axboe@suse.de, diablod3@gmail.com,
	dwmw2@infradead.org, eric@lammerts.org, james.bottomley@steeleye.com,
	linux-kernel@vger.kernel.org
References: <200408101427.i7AERDld014134@burner.fokus.fraunhofer.de> <20040810164947.7f363529.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <20040810164947.7f363529.skraw@ithnet.com>
X-Operating-System: Linux mail 2.6.8-rc4 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-08-10 16:49:47 +0200, Stephan von Krawczynski <skraw@ithnet.co=
m>
wrote in message <20040810164947.7f363529.skraw@ithnet.com>:
> On Tue, 10 Aug 2004 16:27:13 +0200 (CEST)
> Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> >=20
> > -	These distributions do not talk with the original Authors which
> > 	demonstrates that they do not like to benefit from OSS.
>=20
> Really, have you listened to yourself lately: "Commercial distros do not =
like
> to benefit from OSS." ???=20
> How do you define their primary goal, arguing with Joerg Schilling, or wh=
at?

IIRC J=F6rg complained some hundred emails ago that they (the SuSE people)
don't care to try to get their patches upstream, back to J=F6rg, or
discussing their changes with him (but instead hacking cdrecord the way
it fits best for them).

While they (and any other distro's people and anybody else) may actually
hack the code to no end, I consider it being good habit to actually
*avoid* forking without the intent to (constantly) work in re-merging
the fork. While this is perfectly legal, I can understand that J=F6rg
(even while using a broken email client 8-)  doesn't like getting
complains about a hacked cdrecord, or missing useful changes the
distribution people did to cdrecord...


So what's commercial distro's primary goal?  (1) Re-packaging
software for the sole purpose of earning some $$ or  (2) acting as
a mediator between upstream authors and their paying customers?


If it is all about (1), I for one would consider (at least for my future
work) to not continue without actually *forcing* vendors into discussing
their useful changes with me as an upstream author. Like working IN but
not solely FOR a community...

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Irak! =
  O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBGOjKHb1edYOZ4bsRAiLlAJ40VhFgOlRZL64ORqUI4p/tF8CiHgCdGvDg
468y6W700gGlp01FvDcj/F4=
=HmiR
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
