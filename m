Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264445AbSIVRvk>; Sun, 22 Sep 2002 13:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264450AbSIVRvk>; Sun, 22 Sep 2002 13:51:40 -0400
Received: from moutng.kundenserver.de ([212.227.126.185]:33263 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S264445AbSIVRvk>; Sun, 22 Sep 2002 13:51:40 -0400
Date: Sun, 22 Sep 2002 19:56:17 +0200
From: Martin Hermanowski <martin@martin.mh57.net>
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UML error message clone failed/new thread failed
Message-ID: <20020922175617.GO15310@martin.mh57.net>
References: <20020922093040.GL15310@martin.mh57.net> <200209221550.g8MFoQN06125@karaya.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="veXX9dWIonWZEC6h"
Content-Disposition: inline
In-Reply-To: <200209221550.g8MFoQN06125@karaya.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2002 at 11:50:26AM -0400, Jeff Dike wrote:
> martin@martin.mh57.net said:
> > The host is running a vanilla 2.4.17, the UML is the one in Debian
> > Woody (2.4.18.17um-1)
>=20
> That's a fairly old UML.  If you can make it happen with something more
> recent, I'd be interested.

I will try something more recent, but I don't think this will happen
soon again. The UML that had the problems is running a mailserver with
amavis and spamd, it has an uptime of about 28 days. The other UMLs on
the same host are running for 73 days now, without any problems.=20

I had problems with to many processes inside the UML before, but not
like this. Processes in the UML timed out (exim pipe delivery) and new
ones could not be started, but I cannot see the reason.

Regards,
Martin

--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9jgRBV3BRtc7IW1wRAqK0AJ0XrYQrzXUPC8t/w4K1xJAhb0RrSACaApKe
Do7ygqGlZFgCyz3MUf5WtGE=
=bBvU
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--
