Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292739AbSBUT55>; Thu, 21 Feb 2002 14:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292741AbSBUT5q>; Thu, 21 Feb 2002 14:57:46 -0500
Received: from smtpsrv1.isis.unc.edu ([152.2.1.138]:28843 "EHLO
	smtpsrv1.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S292739AbSBUT5c>; Thu, 21 Feb 2002 14:57:32 -0500
Date: Thu, 21 Feb 2002 14:57:24 -0500
To: Shawn Starr <spstarr@sh0n.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM]: 2.4.18-rc1 - Unable to mount CD-ROM/RW
Message-ID: <20020221195724.GA11435@opeth.ath.cx>
In-Reply-To: <LI5YSPXWYTY04431V32LFIF97042TP.3c7534b4@jss> <1014316330.8812.27.camel@unaropia>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <1014316330.8812.27.camel@unaropia>
User-Agent: Mutt/1.3.27i
From: Dan Chen <crimsun@email.unc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 21, 2002 at 01:31:42PM -0500, Shawn Starr wrote:
> It's an LFS distribution i built. The problem is 2.4.17 didn't have this
> problem. Something introduced into 2.4.18-pre/rc.

Hmm, when I spoke with you this morning on #kn I forgot to mention I'm
using rc2-ac1, which as someone else mentioned, doesn't exhibit the
symptoms you describe. Were the sg changes/updates ever applied to 2.4
mainline? I know they went into Alan's tree in .12 or .13 ...

--=20
Dan Chen                 crimsun@email.unc.edu
GPG key:   www.unc.edu/~crimsun/pubkey.gpg.asc

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8dVEkMwVVFhIHlU4RAuZQAJ9EdjbM8VnIng76DepMJrniOu5XeQCbBaJT
gM8zdUwi4KdASuQFRyVFGeE=
=/BZy
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
