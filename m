Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313328AbSDLDpr>; Thu, 11 Apr 2002 23:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313330AbSDLDpq>; Thu, 11 Apr 2002 23:45:46 -0400
Received: from mx1.afara.com ([63.113.218.20]:32404 "EHLO afara-gw.afara.com")
	by vger.kernel.org with ESMTP id <S313328AbSDLDpq>;
	Thu, 11 Apr 2002 23:45:46 -0400
Subject: Re: IRIX NFS server and Linux NFS client
From: Thomas Duffy <tduffy@afara.com>
To: Steffen Persvold <sp@scali.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0204120519150.10585-100000@elin.scali.no>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-/m9Fbs4davTzt3V0wwUK"
X-Mailer: Ximian Evolution 1.0.3 
Date: 11 Apr 2002 20:44:52 -0700
Message-Id: <1018583094.3112.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-OriginalArrivalTime: 12 Apr 2002 03:45:40.0561 (UTC) FILETIME=[83EAE410:01C1E1D4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/m9Fbs4davTzt3V0wwUK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2002-04-11 at 20:22, Steffen Persvold wrote:

> Hmm It's IRIX 6.4 and unfortunately the server can''t be upgraded. Is
> there a ChangeLog somewhere (for IRIX) which describes the changes you
> mention a bit more in detail ? I looked at the SGI homepage, but I didn't
> seem to find
> it.

AHHH.  IRIX 6.4...yuck.  All bets are off for that one.  IRIX 6.3 and
6.4 were probably the worst releases ever (said in comic guy voice :).=20
6.3 was a one-off to support the o2 and 6.4 was a one-off to support the
Origin 2xxx series.  I would *highly* recommend upgrading to 6.5.x.

For one, NFS v3 was not very mature in the 6.4 days.  I would stick to
NFS v2 if you cannot upgrade the OS.  But *please* upgrade the OS :)

-tduffy

--=-/m9Fbs4davTzt3V0wwUK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8tlg0dY502zjzwbwRAr2KAJ9ve03tSJm5ZBG+5U6QlFTEJcxrrwCdG7Qz
h1oEfwsLQd6cG6MiBN2kuMg=
=/Xk9
-----END PGP SIGNATURE-----

--=-/m9Fbs4davTzt3V0wwUK--

