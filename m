Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbVIZOXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbVIZOXE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 10:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbVIZOXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 10:23:04 -0400
Received: from mail.gmx.de ([213.165.64.20]:53436 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751009AbVIZOXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 10:23:02 -0400
X-Authenticated: #815327
From: Malte =?utf-8?q?Schr=C3=B6der?= <maltesch@gmx.de>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Subject: Re: Problem with nfs4, kernel 2.6.13.2
Date: Mon, 26 Sep 2005 16:21:24 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200509251516.23862.MalteSch@gmx.de> <1127737730.8453.5.camel@lade.trondhjem.org>
In-Reply-To: <1127737730.8453.5.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1670934.05x54zmcgi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509261621.37592.maltesch@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1670934.05x54zmcgi
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 26 September 2005 14:28, Trond Myklebust wrote:
> Could you give us some details about your setup (client _and_ server)
> please?

Clients and server are running Debian/Sid (one client amd64, the rest i386)=
=20
with given kernel version. Nfs userspace is at version 1.0.7. The kernel wa=
s=20
made using Debian's "gcc version 4.0.2 20050917 (prerelease) (Debian=20
4.0.1-8))".
The server is using the kernelspace server.

> Also, is this something that is NFSv4 only, or can you reproduce it on
> NFSv2/v3 too?

I will try. But i will have to reconfigure client and server first ...

--nextPart1670934.05x54zmcgi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDOAPx4q3E2oMjYtURApylAKDpt0VtLMPhF2o4ws2utrV9w5Y/LACglFXA
yErBQT2UduFhnHqTiAvT1cQ=
=kcAh
-----END PGP SIGNATURE-----

--nextPart1670934.05x54zmcgi--
