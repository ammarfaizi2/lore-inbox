Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267593AbUHJQ5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267593AbUHJQ5j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 12:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267605AbUHJQy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 12:54:58 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:53891 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S267588AbUHJQwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 12:52:12 -0400
Date: Tue, 10 Aug 2004 18:52:08 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: schilling@fokus.fraunhofer.de, alan@lxorguk.ukuu.org.uk, axboe@suse.de,
       diablod3@gmail.com, dwmw2@infradead.org, eric@lammerts.org,
       james.bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040810165208.GE1127@lug-owl.de>
Mail-Followup-To: Stephan von Krawczynski <skraw@ithnet.com>,
	schilling@fokus.fraunhofer.de, alan@lxorguk.ukuu.org.uk,
	axboe@suse.de, diablod3@gmail.com, dwmw2@infradead.org,
	eric@lammerts.org, james.bottomley@steeleye.com,
	linux-kernel@vger.kernel.org
References: <200408101427.i7AERDld014134@burner.fokus.fraunhofer.de> <20040810164947.7f363529.skraw@ithnet.com> <20040810152458.GA1127@lug-owl.de> <20040810174814.414c8fdd.skraw@ithnet.com> <20040810161056.GB1127@lug-owl.de> <20040810184718.769c046f.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h56sxpGKRmy85csR"
Content-Disposition: inline
In-Reply-To: <20040810184718.769c046f.skraw@ithnet.com>
X-Operating-System: Linux mail 2.6.8-rc4 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h56sxpGKRmy85csR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-08-10 18:47:18 +0200, Stephan von Krawczynski <skraw@ithnet.co=
m>
wrote in message <20040810184718.769c046f.skraw@ithnet.com>:
> On Tue, 10 Aug 2004 18:10:57 +0200
> Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:
>=20
> > Actually, I use Debian since, um, long ago:)  But accept that J=F6rg
> > doesn't really like to care about f*cked up patched versions of
> > cdrecord.
>=20
> He does not need to. Nobody told him to do.

Net being legally or by contract *in charge* to do some supportative
work doesn't mean to be asked to do that or to be expected to do that.

However, I for one *expect* people to help out if they can. ...and J=F6rg
is probably one of those who actually *know* all those shiny toasters
better than most of us.

MfG, JBG (who'll now continue to find the sense data from NCR5380.c ...)

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Irak! =
  O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--h56sxpGKRmy85csR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBGP04Hb1edYOZ4bsRAjzKAJ0Y5pNH0ub1bDEdh1nhP0Zvi4u15wCdEh/q
ppQ8Nhtrh9IzQMqCbowH1pA=
=4rYU
-----END PGP SIGNATURE-----

--h56sxpGKRmy85csR--
