Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273135AbRJBMxn>; Tue, 2 Oct 2001 08:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273204AbRJBMxc>; Tue, 2 Oct 2001 08:53:32 -0400
Received: from ns.snowman.net ([63.80.4.34]:58895 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S273135AbRJBMxQ>;
	Tue, 2 Oct 2001 08:53:16 -0400
Date: Tue, 2 Oct 2001 08:53:27 -0400
From: Stephen Frost <sfrost@snowman.net>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Alan Ford <alan@whirlnet.co.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.11-pre2
Message-ID: <20011002085326.B29860@ns>
Mail-Followup-To: Stephan von Krawczynski <skraw@ithnet.com>,
	Alan Ford <alan@whirlnet.co.uk>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0110011438230.990-100000@penguin.transmeta.com> <200110012218.f91MIGU10233@hswn.dk> <20011002125040.A10878@whirlnet.co.uk> <20011002143939.34e5cd62.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011002143939.34e5cd62.skraw@ithnet.com>; from skraw@ithnet.com on Tue, Oct 02, 2001 at 02:39:39PM +0200
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.2.16 (i686)
X-Uptime: 8:51am  up 411 days, 11:07, 10 users,  load average: 2.00, 2.00, 2.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Stephan von Krawczynski (skraw@ithnet.com) wrote:
> On Tue, 2 Oct 2001 12:50:40 +0100 Alan Ford <alan@whirlnet.co.uk> wrote:
>=20
> > -	action_msg:	"Emergency Remount R/0\n",
> > +	action_msg:	"Emergency Remount R/O\n",
>=20
> What exactly do you want to fix with this patch?

	That changes 'R/0' (R slash Zero) to R/O (R slash O).
	I think 'Read-Only' is what is meant in this 'action_msg'
	and is probably better represented with 'R/O' than 'R/0'.

		Stephen

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD4DBQE7ubjGrzgMPqB3kigRAhFEAJiafdvWtvJBiPM0o+iic4j2iUNEAJkB1wm3
5wbSfu9si+glgOTI9z3rBw==
=9UqI
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
