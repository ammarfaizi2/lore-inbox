Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263965AbTKZF4N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 00:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263969AbTKZF4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 00:56:13 -0500
Received: from smtp2.actcom.co.il ([192.114.47.15]:43909 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S263965AbTKZF4J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 00:56:09 -0500
Date: Wed, 26 Nov 2003 07:55:57 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Pat Erley <paterley@drunkencodepoets.servebeer.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] trivial change in kernel/sched.c in 2.6.0-test9+
Message-ID: <20031126055556.GC3734@actcom.co.il>
References: <20031126002713.1f8707f8.paterley@mail.drunkencodepoets.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Content-Disposition: inline
In-Reply-To: <20031126002713.1f8707f8.paterley@mail.drunkencodepoets.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2003 at 12:27:13AM -0500, Pat Erley wrote:

> this ends up saving a few math operations any time a child
> process exits. ( calling sched_exit(task_t * p) )

Yes, but does it have any noticeable effect on performance whatsoever?
premature optimization, root of all evil, etc.=20

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

"the nucleus of linux oscillates my world" - gccbot@#offtopic


--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/xEBsKRs727/VN8sRAnUGAJ9r/SrhDw5hjUxOuEwgSxza5UYYPgCgr7Ix
oh+GS/aW/ZMVqWU6XrcA3Nc=
=D1aN
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
