Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUC3UMc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 15:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbUC3UMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 15:12:32 -0500
Received: from smtp07.wxs.nl ([195.121.6.39]:39871 "EHLO smtp07.wxs.nl")
	by vger.kernel.org with ESMTP id S261236AbUC3UM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 15:12:29 -0500
Date: Tue, 30 Mar 2004 22:12:25 +0200
From: Arvind Autar <Autar022@planet.nl>
Subject: Re: nicksched v30
In-reply-to: <4068BC7D.2020805@yahoo.com.au>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jason Cox <jpcox@iastate.edu>, "n.v.t n.v.t" <joefso@hotmail.com>
Message-id: <1080677545.31904.38.camel@debian>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.6
Content-type: multipart/signed; boundary="=-awc52Y9/ailukviURq81";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <4048204E.8000807@cyberone.com.au> <4063EAF7.8090405@gmx.de>
 <1080598780.5933.8.camel@debian> <4068BC7D.2020805@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-awc52Y9/ailukviURq81
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-03-30 at 22:07, n.v.t n.v.t wrote:

> I have been having trouble compiling the -mm kernel 2.6.5-rc3-mm1 with v3=
0.=20
> Please help.


A friend of mine has been having compile troubles also.
I used this patch to make things compile:
http://www.liquidweb.nl/~arvind/patches/compile-fix.gz

* I don't know if this will breaks things, it seems empirical to me.*

Arvind.

--=20
Arvind Autar | GnuPG-Key ID: 336E5788
Key fingerprint =3D FAB8 B3E5 0059 880A 00B8  C859 350E BBDC 336E 5788

--=-awc52Y9/ailukviURq81
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAadSpNQ673DNuV4gRAn13AJ4hrp443pquzww9/bRfVcodASQYFACg2a55
ReJB/msqsnLrvSOELKxKATg=
=5NZd
-----END PGP SIGNATURE-----

--=-awc52Y9/ailukviURq81--

