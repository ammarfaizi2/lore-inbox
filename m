Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311437AbSCMXfN>; Wed, 13 Mar 2002 18:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311438AbSCMXfE>; Wed, 13 Mar 2002 18:35:04 -0500
Received: from runyon.sfbay.redhat.com ([205.180.230.5]:11445 "HELO cygnus.com")
	by vger.kernel.org with SMTP id <S311437AbSCMXex>;
	Wed, 13 Mar 2002 18:34:53 -0500
Subject: Re: libc/1427: gprof does not profile threads <synopsis of the
	problem  (one li\ne)>
From: Ulrich Drepper <drepper@redhat.com>
To: Dan Kegel <dkegel@ixiacom.com>
Cc: darkeye@tyrell.hu, libc-gnats@gnu.org, gnats-admin@cygnus.com, sam@zoy.org,
        Xavier Leroy <Xavier.Leroy@inria.fr>, linux-kernel@vger.kernel.org
In-Reply-To: <3C8FDE12.D4A5B50B@ixiacom.com>
In-Reply-To: <3C8FDE12.D4A5B50B@ixiacom.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-ewIhpeW+RtRm+uaRUp2G"
X-Mailer: Evolution/1.0.2 (1.0.2-0.7x) 
Date: 13 Mar 2002 15:34:46 -0800
Message-Id: <1016062486.16743.1091.camel@myware.mynet>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ewIhpeW+RtRm+uaRUp2G
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2002-03-13 at 15:17, Dan Kegel wrote:

> So let's break the logjam and fix glibc's linuxthreads' pthread_create to=
 do
> this.

I will add nothing like this.  The implementation is broken enough and
any addition just makes it worse.  If you patch your own code you'll get
what you want at your own risk.

--=20
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------

--=-ewIhpeW+RtRm+uaRUp2G
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8j+IW2ijCOnn/RHQRAjRoAJsGojSUasimnZQk+fHPnq4D9kl4jwCfSOgy
TgIMK0brn3chSMrx+ikG6v4=
=wLno
-----END PGP SIGNATURE-----

--=-ewIhpeW+RtRm+uaRUp2G--

