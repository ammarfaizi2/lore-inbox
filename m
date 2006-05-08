Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWEHS2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWEHS2G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 14:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWEHS2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 14:28:06 -0400
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:16579 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S1751255AbWEHS2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 14:28:05 -0400
Subject: Re: [dm-crypt] dm-crypt is broken and causes massive data
	corruption
From: Christophe Saout <christophe@saout.de>
To: bart@hsn.net
Cc: dm-crypt@saout.de, linux-kernel@vger.kernel.org,
       Tillmann Steinbrecher <tsteinbr@igd.fraunhofer.de>
In-Reply-To: <1147111049.31050.5.camel@localhost>
References: <445F7DCC.2000508@igd.fraunhofer.de>
	 <1147111049.31050.5.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tFDGe0I9z04fpKTT9PtY"
Date: Mon, 08 May 2006 20:27:31 +0200
Message-Id: <1147112851.9046.14.camel@leto.intern.saout.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tFDGe0I9z04fpKTT9PtY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Montag, den 08.05.2006, 13:57 -0400 schrieb Simpson, Brett:

> I've been running Gentoo for over month with a 54GB ext3 filesystem via
> dm-crypt on an IDE drive. No problems so far.

It's a problem with dm-crypt on top of md. I'm trying to figure out
what's going on there.


--=-tFDGe0I9z04fpKTT9PtY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEX42SZCYBcts5dM0RAqV3AJ9HeuFNhDaTHYpkbjeWUG5jjKZwjQCfVrl7
oSCPU/HgBdSuq4JjAShJmF0=
=MZlh
-----END PGP SIGNATURE-----

--=-tFDGe0I9z04fpKTT9PtY--

