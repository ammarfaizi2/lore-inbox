Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267514AbUHJQSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267514AbUHJQSN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 12:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267548AbUHJQRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 12:17:30 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:29569 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S267514AbUHJQK5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 12:10:57 -0400
Date: Tue, 10 Aug 2004 18:10:57 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: schilling@fokus.fraunhofer.de, alan@lxorguk.ukuu.org.uk, axboe@suse.de,
       diablod3@gmail.com, dwmw2@infradead.org, eric@lammerts.org,
       james.bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040810161056.GB1127@lug-owl.de>
Mail-Followup-To: Stephan von Krawczynski <skraw@ithnet.com>,
	schilling@fokus.fraunhofer.de, alan@lxorguk.ukuu.org.uk,
	axboe@suse.de, diablod3@gmail.com, dwmw2@infradead.org,
	eric@lammerts.org, james.bottomley@steeleye.com,
	linux-kernel@vger.kernel.org
References: <200408101427.i7AERDld014134@burner.fokus.fraunhofer.de> <20040810164947.7f363529.skraw@ithnet.com> <20040810152458.GA1127@lug-owl.de> <20040810174814.414c8fdd.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
In-Reply-To: <20040810174814.414c8fdd.skraw@ithnet.com>
X-Operating-System: Linux mail 2.6.8-rc4 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-08-10 17:48:14 +0200, Stephan von Krawczynski <skraw@ithnet.co=
m>
wrote in message <20040810174814.414c8fdd.skraw@ithnet.com>:
> On Tue, 10 Aug 2004 17:24:59 +0200
> Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:
>=20
> > IIRC J=F6rg complained some hundred emails ago that they (the SuSE peop=
le)
> > don't care to try to get their patches upstream, back to J=F6rg, or
> > discussing their changes with him (but instead hacking cdrecord the way
> > it fits best for them).
>=20
> Have you followed this thread? I can very well imagine what kind of a mes=
s it
> may be to get a patch accepted "upstream".
> In fact I would have dropped this idea, too.

Yes, I've read this whole thread. ...and I know, too, what amount of
hard work is required to get patches upstream. It's a *lot* more work
than needed to actually implement the chance beforehand.

> > While they (and any other distro's people and anybody else) may actually
> > hack the code to no end, I consider it being good habit to actually
> > *avoid* forking without the intent to (constantly) work in re-merging
> > the fork. While this is perfectly legal, I can understand that J=F6rg
> > (even while using a broken email client 8-)  doesn't like getting
> > complains about a hacked cdrecord, or missing useful changes the
> > distribution people did to cdrecord...
>=20
> Sometimes forking is unavoidable and necessary. On Joergs side things are
> pretty easy. All he has to tell the people is that according to the versi=
on
> spec they sent he refuses to help them, because they use a forked version.
> The true story behind may be that nobody wants to use his version for cer=
tain
> pecularities and that therefore merely no feedback is reaching him (any m=
ore).

Get real. Most people actually *use* distros, and many of them actually
*fail* to put the bugs into the distro's BTS. Instead, the author (or
whomever they think is the author) is written to. And guess? And I can
well imaging that J=F6rg doesn't like getting complains about hacked
cdrecord versions because people fail to *read* that this isn't a "pure"
incarnation.

> > So what's commercial distro's primary goal?  (1) Re-packaging
> > software for the sole purpose of earning some $$ or  (2) acting as
> > a mediator between upstream authors and their paying customers?
> >=20
> > If it is all about (1), I for one would consider (at least for my future
> > work) to not continue without actually *forcing* vendors into discussing
> > their useful changes with me as an upstream author. Like working IN but
> > not solely FOR a community...
>=20
> Don't try to press politics onto distros. See what they really are: compa=
nies.
> All companies want to earn bucks, that's what they are for.
> If you don't like that, use debian. You got the choice, that's the fine p=
art
> about it.

Actually, I use Debian since, um, long ago:)  But accept that J=F6rg
doesn't really like to care about f*cked up patched versions of
cdrecord.  And right, that's a completely different topic compared to
possible bugs/non-documented APIs etc. J=F6rg is complaining about.

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

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBGPOQHb1edYOZ4bsRAsGqAJ0VxvVmirJH/LdMOeBS9CCi3iJ65wCfcr61
cPA4THfH5PNbJx52p9eSC+g=
=8K5z
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
