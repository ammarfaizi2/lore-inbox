Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUCVUXg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 15:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbUCVUXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 15:23:36 -0500
Received: from mx1.actcom.co.il ([192.114.47.13]:44703 "EHLO
	smtp1.actcom.co.il") by vger.kernel.org with ESMTP id S262547AbUCVUX0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 15:23:26 -0500
Date: Mon, 22 Mar 2004 22:22:21 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Jos Hulzink <jos@hulzink.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OSS: cleanup or throw away
Message-ID: <20040322202220.GA13042@mulix.org>
References: <200403221955.52767.jos@hulzink.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xFHWmGwbilGjB8dh"
Content-Disposition: inline
In-Reply-To: <200403221955.52767.jos@hulzink.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xFHWmGwbilGjB8dh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 22, 2004 at 07:55:52PM +0100, Jos Hulzink wrote:
> Hi,
>=20
> While fixing some "deprecated" issues in the OSS drivers, I wondered whet=
her=20
> this makes sense, as entire OSS is marked deprecated. Will OSS make it un=
til=20
> 2.7, or will it be dropped soon ? (In other words, should I take care of =
the=20
> OSS drivers or not bother about them)

In my not so humble opinion, throwing OSS away will be a big mistake,
as long as there are people willing to maintain it. Keep it there and
let the users (or distributions) choose what to use. I've seen
multiple bug reports of cards that work with OSS and don't work with
ALSA (and vice versa), so keeping both seems the proper thing to
do. Personally, I maintain one OSS driver, and fix bugs in others
occasionally.=20

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/


--xFHWmGwbilGjB8dh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAX0r7KRs727/VN8sRApZuAJ4uLScomMbLON6lqiwM0T6Y4MYUfwCgoslI
N0aFCBZ/cgyJ/0tXG6rIGR0=
=9caC
-----END PGP SIGNATURE-----

--xFHWmGwbilGjB8dh--
