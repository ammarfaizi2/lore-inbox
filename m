Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293289AbSCAQa2>; Fri, 1 Mar 2002 11:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293269AbSCAQ3J>; Fri, 1 Mar 2002 11:29:09 -0500
Received: from smtpsrv1.isis.unc.edu ([152.2.1.138]:7851 "EHLO
	smtpsrv1.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S293228AbSCAQ3B>; Fri, 1 Mar 2002 11:29:01 -0500
Date: Fri, 1 Mar 2002 11:28:07 -0500
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in the tree
Message-ID: <20020301162807.GB16716@opeth.ath.cx>
In-Reply-To: <Pine.LNX.3.96.1020228174142.2006I-100000@gatekeeper.tmr.com> <Pine.LNX.4.33L.0202282002260.2801-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0202282002260.2801-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.27i
From: Dan Chen <crimsun@email.unc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 28, 2002 at 08:04:38PM -0300, Rik van Riel wrote:
> the drivers to use it isn't that hard. Now all that's needed
> are some O(1) fans willing to do the grunt work.

After a simple set of egreps, I've cobbled together a patch that adds
Davide's #define to include/linux/sched.h and modifies corresponding
places over the entire tree. It's coming separately.

--=20
Dan Chen                 crimsun@email.unc.edu
GPG key:   www.unc.edu/~crimsun/pubkey.gpg.asc

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8f6wXMwVVFhIHlU4RArk5AJ9tF8PnkBh/lQpjN7Oj8JoYVjXhCACfYkSA
tBTYzI+NNoz1hjNGXLDCQFY=
=qY/s
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
