Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293626AbSCATFd>; Fri, 1 Mar 2002 14:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293632AbSCATFH>; Fri, 1 Mar 2002 14:05:07 -0500
Received: from smtpsrv0.isis.unc.edu ([152.2.1.139]:48311 "EHLO
	smtpsrv0.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S293626AbSCATDr>; Fri, 1 Mar 2002 14:03:47 -0500
Date: Fri, 1 Mar 2002 14:03:26 -0500
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] #define yield() for 2.4 scheduler (anticipating O(1))
Message-ID: <20020301190326.GA21767@opeth.ath.cx>
In-Reply-To: <20020301163237.GC16716@opeth.ath.cx> <20020301185825.GK2711@matchmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <20020301185825.GK2711@matchmail.com>
User-Agent: Mutt/1.3.27i
From: Dan Chen <crimsun@email.unc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2002 at 10:58:25AM -0800, Mike Fedyk wrote:
> is __set_current_state(TASK_RUNNING) compatible with the new scheduler?

Yes.

--=20
Dan Chen                 crimsun@email.unc.edu
GPG key:   www.unc.edu/~crimsun/pubkey.gpg.asc

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8f9B+MwVVFhIHlU4RAkaxAKCDuP26Jfk6lJalJ2Kej+eIyamPQACfYvbz
Kl3nxBOb/UVhzPePKdEXDqM=
=1RB4
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
