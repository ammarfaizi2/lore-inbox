Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293556AbSCPAT7>; Fri, 15 Mar 2002 19:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293591AbSCPATt>; Fri, 15 Mar 2002 19:19:49 -0500
Received: from runyon.sfbay.redhat.com ([205.180.230.5]:8166 "HELO cygnus.com")
	by vger.kernel.org with SMTP id <S293556AbSCPATc>;
	Fri, 15 Mar 2002 19:19:32 -0500
Subject: Re: libc/1427: gprof does not profile threads <synopsis of the
	problem  (one li\ne)>
From: Ulrich Drepper <drepper@redhat.com>
To: Dan Kegel <dank@ixiacom.com>
Cc: Jakub Jelinek <jakub@redhat.com>, Dan Kegel <dkegel@ixiacom.com>,
        darkeye@tyrell.hu, libc-gnats@gnu.org, gnats-admin@cygnus.com,
        sam@zoy.org, Xavier Leroy <Xavier.Leroy@inria.fr>,
        linux-kernel@vger.kernel.org, Bill Abt <babt@us.ibm.com>
In-Reply-To: <3C926E0B.1A0EE311@ixiacom.com>
In-Reply-To: <1016062486.16743.1091.camel@myware.mynet>
	<3C8FEC76.F1411739@ixiacom.com>
	<20020314020834.Z2434@devserv.devel.redhat.com> 
	<3C926E0B.1A0EE311@ixiacom.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-iFxTiE5tRSlJxvp26g06"
X-Mailer: Evolution/1.0.2 (1.0.2-0.7x) 
Date: 15 Mar 2002 16:19:17 -0800
Message-Id: <1016237961.5612.51.camel@myware.mynet>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iFxTiE5tRSlJxvp26g06
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2002-03-15 at 13:56, Dan Kegel wrote:

> Ulrich, do you at least agree that it would be desirable for
> gprof to work properly on multithreaded programs?

No.  gprof is uselss in today world.

--=20
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------

--=-iFxTiE5tRSlJxvp26g06
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8ko+F2ijCOnn/RHQRAkXdAKC1nLqpQvQ3ZoWxoD3msQfqWded0QCdFkuG
SslMVwKR1TTR9oZ1WSZdxE8=
=hN3d
-----END PGP SIGNATURE-----

--=-iFxTiE5tRSlJxvp26g06--

