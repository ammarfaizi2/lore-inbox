Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265196AbUHYKBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265196AbUHYKBe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 06:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbUHYKBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 06:01:33 -0400
Received: from hr27206.wlan.dnafinland.fi ([62.237.27.206]:5504 "EHLO
	lemmiwinks.internal.linux-sh.org") by vger.kernel.org with ESMTP
	id S266366AbUHYKAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 06:00:32 -0400
Date: Wed, 25 Aug 2004 11:53:32 +0300
From: Paul Mundt <lethal@linux-sh.org>
To: Valdis.Kletnieks@vt.edu
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.9-rc1 - #ifdef cleanup for sh64
Message-ID: <20040825085332.GA3127@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Valdis.Kletnieks@vt.edu, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200408241402.i7OE2nJC001362@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <200408241402.i7OE2nJC001362@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 24, 2004 at 10:02:49AM -0400, Valdis.Kletnieks@vt.edu wrote:
> Another small cleanup patch for #if/#ifdef usage.
>=20
> Signed-off-by: valdis.kletnieks@vt.edu
>=20
I thought I got all of these before, but it appears this one snuck by.
I've applied it, thanks.


--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBLFOM1K+teJFxZ9wRAvnzAJsGqaOMc2OGsbN21QLzRuYxVOM4jwCfcrsu
0A8GpY+yVVlkYwFaOakj5K4=
=7IQ5
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
