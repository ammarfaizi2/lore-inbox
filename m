Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284144AbSASOvz>; Sat, 19 Jan 2002 09:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286687AbSASOvq>; Sat, 19 Jan 2002 09:51:46 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:14742 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S284144AbSASOvl>; Sat, 19 Jan 2002 09:51:41 -0500
Date: Sat, 19 Jan 2002 09:51:32 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: Doug Alcorn <lathi@seapine.com>, linux-kernel@vger.kernel.org
Subject: Re: rm-ing files with open file descriptors
Message-ID: <20020119145132.GA972@online.fr>
Mail-Followup-To: Doug Alcorn <lathi@seapine.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <87lmevjrep.fsf@localhost.localdomain> <20020119041857.GA10795@storm.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <20020119041857.GA10795@storm.local>
User-Agent: Mutt/1.3.25i
X-Operating-System: debian SID Gnu/Linux 2.4.17 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 19, 2002 at 05:18:57AM +0100, Andreas Bombe wrote:
> Whether that was an intended or accidental feature only someone with
> more insight into Unix history can answer.  It's that feature that lets
> us do live upgrades of distributions without rebooting (executables and
> libraries can be replaced without affecting the currently running
> processes), at the very least much easier than it would be without this
> behaviour.

I remember that previous debian release come with a patched kernel to
allow live upgrade. It was explained in the FAQ that the patch was
required for this purpose.

   7.2 Debian claims to be able to update a running program;
      how is this accomplished?

The debian FAQ has been updated because now debian uses a pristine
kernel.

What was in this patch?

Christophe

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

Cats are rather delicate creatures and they are subject to a good
many ailments, but I never heard of one who suffered from insomnia.
--Joseph Wood Krutch

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8SYf0j0UvHtcstB4RAloPAJ9K+Mz1YufkDLJNwXQs8e2TM47s7gCgmLj4
JoPsepcVW49b4AzrBYwfTGY=
=6X2e
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
