Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbWEBVBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbWEBVBi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 17:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbWEBVBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 17:01:38 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:20116 "EHLO
	fmmailgate02.web.de") by vger.kernel.org with ESMTP id S964971AbWEBVBh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 17:01:37 -0400
From: Michael Helmling <supermihi@web.de>
To: "Ioan Ionita" <opslynx@gmail.com>
Subject: Re: New, yet unsupported USB-Ethernet adaptor
Date: Tue, 2 May 2006 23:03:08 +0200
User-Agent: KMail/1.9.1
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200605022002.15845.supermihi@web.de> <df47b87a0605021340v1c3901e9r17eb3c69034b7487@mail.gmail.com>
In-Reply-To: <df47b87a0605021340v1c3901e9r17eb3c69034b7487@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5718953.2HtbYpKSo6";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200605022303.10832.supermihi@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5718953.2HtbYpKSo6
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline



Am Dienstag 02 Mai 2006 22:40 schrieb Ioan Ionita:
> On 5/2/06, Michael Helmling <supermihi@web.de> wrote:
> > Thank you very much for the immediate answer.
> > I applied the patch  - well, I had to do this manually, for some reason=
, I
> > assume bad formatting in my mail program, patch -p0 < patch1 didn't wor=
k.=20
Or
> > am I using the wrong command?
>=20
> You shoud use patch -p1< patch

$ patch -p1 < patch
patching file mcs7830.c
Hunk #1 FAILED at 1309.
Hunk #2 FAILED at 1370.
Hunk #3 FAILED at 1503.
Hunk #4 FAILED at 1935.
Hunk #5 FAILED at 1997.
Hunk #6 FAILED at 2044.
Hunk #7 FAILED at 2404.
7 out of 7 hunks FAILED -- saving rejects to file mcs7830.c.rej

Don't know why. :( But since it are only a few lines this isn't a major=20
problem.

> Me neither. It was a quick & dirty patch, I must have missed
> something. I'll toy around with it some more.=20

Good luck!
>=20
>=20
> P.S In the future, make sure you use reply-to-all. Thanks

Ok.

--nextPart5718953.2HtbYpKSo6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEV8kOcLJiNWFgTBIRAj3BAJ9IV3ct7wZu3e4N+OvPBAjTPO8EuwCeOGep
rBvOEbsGelyDoYzVLuwvPGw=
=u00D
-----END PGP SIGNATURE-----

--nextPart5718953.2HtbYpKSo6--
