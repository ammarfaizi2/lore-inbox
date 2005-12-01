Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbVLARw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbVLARw2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 12:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVLARw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 12:52:28 -0500
Received: from zlynx.org ([199.45.143.209]:16142 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S932270AbVLARw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 12:52:27 -0500
Subject: Re: loadavg always equal or above 1.00 - how to explain?
From: Zan Lynx <zlynx@acm.org>
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <438EF3E5.5080709@wpkg.org>
References: <438EE515.1080001@wpkg.org>
	 <1133440871.2853.36.camel@laptopd505.fenrus.org>
	 <438EF3E5.5080709@wpkg.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-lCzoGktN59k0bqKMorEQ"
Date: Thu, 01 Dec 2005 10:51:58 -0700
Message-Id: <1133459518.7430.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lCzoGktN59k0bqKMorEQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-12-01 at 14:00 +0100, Tomasz Chmielewski wrote:
[snip]
> Now I have to figure out what CROND was doing...
>=20
> Does ps always show processes in D state in CAPITAL letters?
>=20
> After cron restart it is "crond", as usual.

crond is the regular cron daemon.  CROND is what cron names its child
processes as they run scheduled commands.

I've seen cron stuck in D from running user crontabs on unavailable NFS
mounts.
--=20
Zan Lynx <zlynx@acm.org>

--=-lCzoGktN59k0bqKMorEQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDjzg9G8fHaOLTWwgRAvxyAJ0ahILQntaOs7SJuPQoH6MjdvQ6pwCfSzcd
NnQe9FAPXnWwqVzI8/dU2G0=
=cFFo
-----END PGP SIGNATURE-----

--=-lCzoGktN59k0bqKMorEQ--

