Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271728AbRIGLYC>; Fri, 7 Sep 2001 07:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271729AbRIGLXw>; Fri, 7 Sep 2001 07:23:52 -0400
Received: from ns.snowman.net ([63.80.4.34]:25103 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S271728AbRIGLXn>;
	Fri, 7 Sep 2001 07:23:43 -0400
Date: Fri, 7 Sep 2001 07:23:57 -0400
From: Stephen Frost <sfrost@snowman.net>
To: Robert Love <rml@tech9.net>
Cc: Jordan Breeding <ledzep37@home.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Trouble with update Preemptive patch for 2.4.9-ac9
Message-ID: <20010907072357.A11136@ns>
Mail-Followup-To: Robert Love <rml@tech9.net>,
	Jordan Breeding <ledzep37@home.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3B985287.2385275B@home.com> <999839075.865.7.camel@phantasy>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VElBgCKev1jMvXdS"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <999839075.865.7.camel@phantasy>; from rml@tech9.net on Fri, Sep 07, 2001 at 01:04:33AM -0400
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.2.16 (i686)
X-Uptime: 7:21am  up 386 days,  9:39, 12 users,  load average: 2.00, 2.00, 2.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VElBgCKev1jMvXdS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Robert Love (rml@tech9.net) wrote:
>=20
> I am glad you found an improvement on UP.  Hopefully we can get it
> working on SMP, too.  I have never personally used it on SMP, but I had
> heard it worked.

	If you need a guinea pig for testing it on SMP I may be willing
	to do that on one of my SMP machines. :)  Let me know, I'll need
	to do some setup work (attaching and setting up a serial
	console, testing the machine without the patch to make sure it's
	mostly happy, etc).

		Stephen

--VElBgCKev1jMvXdS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7mK5MrzgMPqB3kigRAowlAJwPmcP8Gj17CPSUJcuTIIAfO3LRjACcCpmL
7+5JNsfWf6o1u1a7fn+cw4Y=
=s4Fb
-----END PGP SIGNATURE-----

--VElBgCKev1jMvXdS--
