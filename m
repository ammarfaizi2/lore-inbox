Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266751AbUFYOy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266751AbUFYOy2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 10:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266752AbUFYOy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 10:54:28 -0400
Received: from [196.25.168.8] ([196.25.168.8]:6793 "EHLO lbsd.net")
	by vger.kernel.org with ESMTP id S266751AbUFYOyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 10:54:25 -0400
Date: Fri, 25 Jun 2004 16:54:03 +0200
From: Nigel Kukard <nkukard@lbsd.net>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: webvenza@libero.it, linux-kernel@vger.kernel.org
Subject: Re: [HANG] SIS900 + P4 Hyperthread
Message-ID: <20040625145403.GI11501@lbsd.net>
References: <40C0E37C.4030905@lbsd.net> <20040604214721.GC22679@picchio.gall.it> <20040605005033.A26051@electric-eye.fr.zoreil.com> <20040605070239.GM14247@lbsd.net> <20040605130526.A31872@electric-eye.fr.zoreil.com> <20040614182737.GG18169@lbsd.net> <20040614203917.A12228@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jaTU8Y2VLE5tlY1O"
Content-Disposition: inline
In-Reply-To: <20040614203917.A12228@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.2.1i
X-PHP-Key: http://www.lbsd.net/~nkukard/keys/gpg_public.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jaTU8Y2VLE5tlY1O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


It must be non-sis900 driver related, is there a way i can get more
debugging info?

error doesn't occur if i enable sis900 debugging, might be because the
hardware isn't operating at full speed.

-Nigel

On Mon, Jun 14, 2004 at 08:39:17PM +0200, Francois Romieu wrote:
> Nigel Kukard <nkukard@lbsd.net> :
> > Any more ideas?  :(
>=20
> Tried to increase NUM_{RX/TX}_DESC ?
>=20

--jaTU8Y2VLE5tlY1O
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFA3DyLKoUGSidwLE4RAqdFAJoD6QmsCitsto1wvHqLmtAXzanfAwCfSrkX
w08Qjq+X5r4KjtTUCmHSe6Y=
=r6Vp
-----END PGP SIGNATURE-----

--jaTU8Y2VLE5tlY1O--
