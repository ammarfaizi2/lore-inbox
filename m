Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265334AbUFOHLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265334AbUFOHLK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 03:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265342AbUFOHLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 03:11:10 -0400
Received: from [196.25.168.8] ([196.25.168.8]:1929 "EHLO lbsd.net")
	by vger.kernel.org with ESMTP id S265334AbUFOHLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 03:11:06 -0400
Date: Tue, 15 Jun 2004 09:10:38 +0200
From: Nigel Kukard <nkukard@lbsd.net>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: webvenza@libero.it, linux-kernel@vger.kernel.org
Subject: Re: [HANG] SIS900 + P4 Hyperthread
Message-ID: <20040615071038.GI18169@lbsd.net>
References: <40C0E37C.4030905@lbsd.net> <20040604214721.GC22679@picchio.gall.it> <20040605005033.A26051@electric-eye.fr.zoreil.com> <20040605070239.GM14247@lbsd.net> <20040605130526.A31872@electric-eye.fr.zoreil.com> <20040614182737.GG18169@lbsd.net> <20040614203917.A12228@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="smOfPzt+Qjm5bNGJ"
Content-Disposition: inline
In-Reply-To: <20040614203917.A12228@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.1i
X-PHP-Key: http://www.lbsd.net/~nkukard/keys/gpg_public.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--smOfPzt+Qjm5bNGJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Can't remember if i tried it last time, but i just tried it again now
and increased it to 256 each. It got 30Mb further than last time in the
2Gb file i was ftp'ing over, but died with the exact same symptoms.



On Mon, Jun 14, 2004 at 08:39:17PM +0200, Francois Romieu wrote:
>=20
> Tried to increase NUM_{RX/TX}_DESC ?
>=20
> --
> Ueimor
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--smOfPzt+Qjm5bNGJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAzqDuKoUGSidwLE4RAiWKAJ44sQ5GK7W74lOrlVEf+BiqhEQVngCgvJsN
boim0jDdG4Dl+5kFuganNuQ=
=X+sE
-----END PGP SIGNATURE-----

--smOfPzt+Qjm5bNGJ--
