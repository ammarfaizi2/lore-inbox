Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266011AbUAVIZA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 03:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266006AbUAVIXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 03:23:40 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:14487 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S265983AbUAVIX2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 03:23:28 -0500
Date: Thu, 22 Jan 2004 21:26:05 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: PATCH: Shutdown IDE before powering off.
In-reply-to: <200401220813.i0M8DX4Q000511@81-2-122-30.bradfords.org.uk>
To: John Bradford <john@grabjohn.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1074759964.12536.65.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-1L1FlHM683Yn00jU9UMu";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <1074735774.31963.82.camel@laptop-linux>
 <20040121234956.557d8a40.akpm@osdl.org>
 <200401220813.i0M8DX4Q000511@81-2-122-30.bradfords.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1L1FlHM683Yn00jU9UMu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

On Thu, 2004-01-22 at 21:13, John Bradford wrote:
> > This spins down the disk(s) when you're just doing do a reboot.  That's
> > fairly irritating and could affect reboot times if one has many disks.
>=20
> I think it is an attempt to force some broken drives to flush their
> cache, but I wonder whether it will simply move the problem from one
> set of broken drives to another :-).

Yes, they were trying to get caches flushed. If this attempt is
misguided, that's fine. Is there a better way?

Regards,

Nigel
--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-1L1FlHM683Yn00jU9UMu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAD4kcVfpQGcyBBWkRAk9GAKCNK7bmjYXey091UxG1YoBJ7M3G3QCgi/R9
iP521x1xgvH/z+SCI1BtwMk=
=C9A9
-----END PGP SIGNATURE-----

--=-1L1FlHM683Yn00jU9UMu--

