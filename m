Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267874AbRGRNYx>; Wed, 18 Jul 2001 09:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267876AbRGRNYn>; Wed, 18 Jul 2001 09:24:43 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:4882 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S267874AbRGRNYb>;
	Wed, 18 Jul 2001 09:24:31 -0400
Date: Wed, 18 Jul 2001 17:24:27 +0400
To: mdaljeet@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: ppc Linux-2.4.2 not generating core dump for SIGSEGV and abort()
Message-ID: <20010718172427.A30098@orbita1.ru>
In-Reply-To: <CA256A8D.0047BE63.00@d73mta01.au.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <CA256A8D.0047BE63.00@d73mta01.au.ibm.com>; from mdaljeet@in.ibm.com on Wed, Jul 18, 2001 at 06:31:25PM +0530
X-Uptime: 5:22pm  up 1 day,  7:58,  1 user,  load average: 0.06, 0.04, 0.00
X-Uname: Linux orbita1.ru 2.2.20pre2-acl 
From: pazke@orbita1.ru
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 18, 2001 at 06:31:25PM +0530, mdaljeet@in.ibm.com wrote:
> Hi all,
>      I am using Suse-linux-7.1 with default linux -ppc kernel on apple G4
> machine.
> SIGSEGV is never generating the core dump. though this signal is being
> caught by the user process.
> I also tried with "abort" call which should generate the core dump, but
> this is also not working. The same program with abort call is generating
> core dumps on other linux/unix platforms.
> Can anybody tell me where is the problem?
>=20
> Daljeet.

What does 'ulimit -a' print ?

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7VY4KBm4rlNOo3YgRApyXAJ9gJpkxyU2T1LrnCWhS7UjYHmntmACfWD6H
9WAnU6pAaH77Oq4bSIzS1PQ=
=1NNe
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
