Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbUJYQaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbUJYQaG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 12:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbUJYQ23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 12:28:29 -0400
Received: from cs181087074.pp.htv.fi ([82.181.87.74]:57838 "EHLO
	Unusual.Internal.Linux-SH.ORG") by vger.kernel.org with ESMTP
	id S262061AbUJYQZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 12:25:13 -0400
Date: Mon, 25 Oct 2004 19:25:10 +0300
From: Paul Mundt <lethal@linux-sh.org>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       trini@kernel.crashing.org
Subject: Re: [PATCH 13/17] 4level support for sh
Message-ID: <20041025162510.GB9937@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Andi Kleen <ak@suse.de>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org, akpm@osdl.org,
	trini@kernel.crashing.org
References: <417CAA06.mail3ZK11VJ7Y@wotan.suse.de> <20041025082232.GA1419@linux-sh.org> <20041025160959.GB26306@verdi.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Content-Disposition: inline
In-Reply-To: <20041025160959.GB26306@verdi.suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 25, 2004 at 06:09:59PM +0200, Andi Kleen wrote:
> BTW separate objdir build seems to be totally broken on sh and=20
> it adds random bogus symlinks to the source tree when you do=20
> that. Perhaps you can fix that too.
>=20
Tom Rini was working on that stuff, I've not tested it myself. I thought
this was all fixed by now though, Tom?


--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBfSjm1K+teJFxZ9wRAhkXAJ4sI57Iy3RamW58uBu/Bztn51CwjACcC07s
+pcrLhR3X1MSv4oqBJ1JI+c=
=6LXj
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
