Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265908AbUACDpu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 22:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265915AbUACDpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 22:45:50 -0500
Received: from smtp.golden.net ([199.166.210.31]:29959 "EHLO
	newsmtp.golden.net") by vger.kernel.org with ESMTP id S265908AbUACDps
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 22:45:48 -0500
Date: Fri, 2 Jan 2004 22:45:42 -0500
From: Paul Mundt <lethal@linux-sh.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-rc1 - Watchdog patches
Message-ID: <20040103034541.GA5479@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Wim Van Sebroeck <wim@iguana.be>, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040103002459.K30061@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <20040103002459.K30061@infomag.infomag.iguana.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Wim,

On Sat, Jan 03, 2004 at 12:24:59AM +0100, Wim Van Sebroeck wrote:
>  drivers/char/watchdog/shwdt.c        |   14 +-
>=20
This change is useless, it's just whitespace modification. Perhaps you may =
want
to be more careful with diff in the future so you don't constantly generate
superfluous changes. There definitely seems to be a lot of whitespace chang=
es
throughout the rest of these patches as well..


--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/9jrl1K+teJFxZ9wRAgozAJ45JuaqEBwpXqk/uBOvNK1t4Sr+KwCfSJWH
I7c006Ll4UJkAFFxy2IfH7Q=
=gDL9
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
