Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317603AbSGaBe5>; Tue, 30 Jul 2002 21:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317622AbSGaBe4>; Tue, 30 Jul 2002 21:34:56 -0400
Received: from florin.dsl.visi.com ([209.98.146.184]:36453 "EHLO
	bird.iucha.org") by vger.kernel.org with ESMTP id <S317603AbSGaBe4>;
	Tue, 30 Jul 2002 21:34:56 -0400
Date: Tue, 30 Jul 2002 20:36:11 -0500
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19rc3-ac5
Message-ID: <20020731013611.GA478@iucha.net>
Mail-Followup-To: Alan Cox <alan@redhat.com>,
	linux-kernel@vger.kernel.org
References: <200207301356.g6UDuq900731@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <200207301356.g6UDuq900731@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook: Where do you want [your files] to go today?
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2002 at 09:56:52AM -0400, Alan Cox wrote:
> Linux 2.4.19rc3-ac5
> o	Warn when mounting ext3 as ext2			(Andrew Morton)

It warns all right but then it doesn't mount it at all. I have my root
on ext3. It spits a lot of errors about not being able to find modules
and dies by the time it gets to syslog.

All kernels up to rc3-ac2 work just fine. (I might have skipped one or
two).

florin

--=20

"If it's not broken, let's fix it till it is."

41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9Rz8KNLPgdTuQ3+QRAn2BAKCdfQFkOHrsJtT5F9QGzObUVed0cQCfSJCG
M/KbfBzR7SjDMCy52kf3nOc=
=n3Br
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
