Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272746AbTG3Ev7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 00:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272759AbTG3Ev7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 00:51:59 -0400
Received: from adsl-67-121-153-186.dsl.pltn13.pacbell.net ([67.121.153.186]:13736
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S272746AbTG3Ev6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 00:51:58 -0400
Date: Tue, 29 Jul 2003 21:51:57 -0700
To: Studying MTD <studying_mtd@yahoo.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.6.0-test1 : modules not working
Message-ID: <20030730045157.GA5655@triplehelix.org>
References: <20030730043717.41712.qmail@web20503.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <20030730043717.41712.qmail@web20503.mail.yahoo.com>
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2003 at 09:37:17PM -0700, Studying MTD wrote:
> modprobe: QM_MODULES: Function not implemented
> modprobe: QM_MODULES: Function not implemented

Next time, please STFW, RTFM (in this case, post-halloween-2.5.txt on
lwn.net), and you would already know that you need module-init-tools,
available at rusty's page on kernel.org.

-Josh

--=20
Using words to describe magic is like using a screwdriver to cut roast beef.
		-- Tom Robbins

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/J07tT2bz5yevw+4RAphlAKCtebbqrb//rc98ZtkNa+vB9KGdKQCgw7ey
6c8G9kp2OEBg4UolZPR9vUc=
=SzyA
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
