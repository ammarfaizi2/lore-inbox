Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264002AbSIVJ0P>; Sun, 22 Sep 2002 05:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263324AbSIVJZw>; Sun, 22 Sep 2002 05:25:52 -0400
Received: from moutng.kundenserver.de ([212.227.126.189]:59354 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S262066AbSIVJZu>; Sun, 22 Sep 2002 05:25:50 -0400
Date: Sun, 22 Sep 2002 11:30:40 +0200
From: Martin Hermanowski <martin@martin.mh57.net>
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UML error message clone failed/new thread failed
Message-ID: <20020922093040.GL15310@martin.mh57.net>
References: <20020921182127.GK15310@martin.mh57.net> <200209211845.g8LIjhC04844@karaya.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
In-Reply-To: <200209211845.g8LIjhC04844@karaya.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 21, 2002 at 02:45:42PM -0400, Jeff Dike wrote:
> martin@martin.mh57.net said:
>>  No new processes could be started in the uml, but why?
>> Is this a problem with the process limits of the host linux?=20
>=20
> Host and UML versions?

The host is running a vanilla 2.4.17, the UML is the one in Debian Woody
(2.4.18.17um-1). I had this errors only once, and I suspect that
something on the host went wrong, but the logs show nothing.

Regards,
Martin

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9jY3AV3BRtc7IW1wRAvjlAJ9ptrQ5WHSPpvi5zlTf0zqHzWZfAACgqPQI
e9Falw4m3fHQoSJpO0db8wU=
=bwrf
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
