Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262582AbVF2OEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262582AbVF2OEp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 10:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbVF2OEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 10:04:45 -0400
Received: from nysv.org ([213.157.66.145]:40941 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S262582AbVF2N6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 09:58:46 -0400
Date: Wed, 29 Jun 2005 16:58:20 +0300
To: Douglas McNaught <doug@mcnaught.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Hubert Chan <hubert@uhoreg.ca>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
Message-ID: <20050629135820.GJ11013@nysv.org>
References: <200506290509.j5T595I6010576@laptop11.inf.utfsm.cl> <m2k6kd2rx8.fsf@Douglas-McNaughts-Powerbook.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Gs9iBZf6UKWgztis"
Content-Disposition: inline
In-Reply-To: <m2k6kd2rx8.fsf@Douglas-McNaughts-Powerbook.local>
User-Agent: Mutt/1.5.9i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Gs9iBZf6UKWgztis
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 29, 2005 at 09:50:27AM -0400, Douglas McNaught wrote:
>
>I'll just note that the "applications bundled as directories" stuff on
>MacOS/NextStep is done completely in userspace--as far as the kernel
>is concerned, "Mail.app" is a regular directory.  The file manager
>handles recognition and invocation of application bundles (and there
>is an 'open' shell command that does the same thing).

Note that MacOS has the monopoly on what they ship, Linux has a
motherload of file managers and window systems and all.

What pisses me off is the fact that Gnome and friends implement
their own incompatible-with-others VFS's and automounters and
stuff.

Surely supporting this in the kernel and extending the LSB
to require this is the best step to take without infringing
anyone's freedom as such.

*still pissed off about having to hassle an automatic mount*

--=20
mjt


--Gs9iBZf6UKWgztis
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCwqj8IqNMpVm8OhwRAoS7AKCruMvI4VKypOTQ1dZF/DXtUHEBvQCgo7gd
yT8NiZUAQ4oPHmgn/hQfexk=
=NsYy
-----END PGP SIGNATURE-----

--Gs9iBZf6UKWgztis--
