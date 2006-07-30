Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbWG3UJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWG3UJV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 16:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWG3UJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 16:09:21 -0400
Received: from lug-owl.de ([195.71.106.12]:41376 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S932472AbWG3UJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 16:09:20 -0400
Date: Sun, 30 Jul 2006 22:09:18 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Nikita Danilov <nikita@clusterfs.com>, Joe Perches <joe@perches.com>,
       Martin Waitz <tali@admingilde.org>,
       Christoph Hellwig <hch@infradead.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
       Sam Ravnborg <sam@ravnborg.org>, Russell King <rmk@arm.linux.org.uk>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH 00/12] making the kernel -Wshadow clean - The initial step
Message-ID: <20060730200918.GI31121@lug-owl.de>
Mail-Followup-To: Jesper Juhl <jesper.juhl@gmail.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Nikita Danilov <nikita@clusterfs.com>, Joe Perches <joe@perches.com>,
	Martin Waitz <tali@admingilde.org>,
	Christoph Hellwig <hch@infradead.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Arjan van de Ven <arjan@infradead.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
	Sam Ravnborg <sam@ravnborg.org>, Russell King <rmk@arm.linux.org.uk>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Randy Dunlap <rdunlap@xenotime.net>
References: <200607301830.01659.jesper.juhl@gmail.com> <9a8748490607301224y63e7e9ah895722efe4c6e371@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJFRpmOek+ZRSQoz"
Content-Disposition: inline
In-Reply-To: <9a8748490607301224y63e7e9ah895722efe4c6e371@mail.gmail.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IJFRpmOek+ZRSQoz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-07-30 21:24:59 +0200, Jesper Juhl <jesper.juhl@gmail.com> wrot=
e:
> On 30/07/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > Ok, here we go again...
> >
> > This is a series of patches that try to be an initial step towards maki=
ng
> > the kernel build -Wshadow clean.
> >
> It would be great if maintainers of the various areas that my patches
> touch would explicitly ack or nack patches - preferably giving reasons
> for nack's as well.

My move to a new town is basically done, so I'll give it a run for the
VAX specific bits which I care about.

MfG, JBG

--=20
       Jan-Benedict Glaw       jbglaw@lug-owl.de                +49-172-760=
8481
 Signature of:                               If it doesn't work, force it.
 the second  :                      If it breaks, it needed replacing anywa=
y.

--IJFRpmOek+ZRSQoz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEzRHuHb1edYOZ4bsRAo08AJ4467WHvxgnqDyacOyMOptmQeRPCQCfWyTe
3hyKIpe38/4/xW5WfZyLnHQ=
=XCWG
-----END PGP SIGNATURE-----

--IJFRpmOek+ZRSQoz--
