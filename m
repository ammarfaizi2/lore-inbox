Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbVCANWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVCANWB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 08:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVCANWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 08:22:01 -0500
Received: from ipp23-131.piekary.net ([80.48.23.131]:17628 "EHLO spock.one.pl")
	by vger.kernel.org with ESMTP id S261901AbVCANVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 08:21:41 -0500
Date: Tue, 1 Mar 2005 14:03:25 +0100
From: Michal Januszewski <spock@gentoo.org>
To: Pavel Machek <pavel@suse.cz>
Cc: mls@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Bootsplash for 2.6.11-rc4
Message-ID: <20050301130325.GB14278@spock.one.pl>
References: <20050218165254.GA1359@elf.ucw.cz> <20050219011433.GA5954@spock.one.pl> <20050228174015.GB1349@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
In-Reply-To: <20050228174015.GB1349@elf.ucw.cz>
X-PGP-Key: http://dev.gentoo.org/~spock/spock.gpg
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 28, 2005 at 06:40:15PM +0100, Pavel Machek wrote:

Hi,
=20
> > It doesn't really need vesafb for anything. Back in the days of 2.6.7=
=20
> > I used to release a version of bootsplash that had the dep. on vesafb=
=20
> > removed. It worked fine with at least some other fb drivers.
> >=20
> > You might also want to save yourself some work and try out an
> > alternative solution called fbsplash [1], which I designed after I got=
=20
> > tired of fixing bootsplash and which I actively maintain. Fbsplash=20
> > provides virtually the same functionality, and it has as much code as=
=20
> > possible moved into userspace (no more JPEG decoders in the kernel).
> mls suggested that there were some problems with matroxfb in the
> past. Have you seen something like that?

Possibly, but I can't recall what exactly was it about. All bugs in
fbsplash, that I have known of, have been fixed. If there are still some
problems with any fb drivers, please let me know.

Live long and prosper.
--=20
Michal 'Spock' Januszewski                        Gentoo Linux Developer
cell: +48504917690                         http://dev.gentoo.org/~spock/
JID: spock@im.gentoo.org               freenode: #gentoo-dev, #gentoo-pl


--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCJGgdaQ0HSaOUe+YRAmy1AJ437kopEOJlY7MAkXYiAilmpqoJnwCgmK4Y
8UtGZSuSwVsnrVKKFsThAhQ=
=A8zk
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
