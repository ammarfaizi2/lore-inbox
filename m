Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135947AbRAHWpD>; Mon, 8 Jan 2001 17:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131342AbRAHWoo>; Mon, 8 Jan 2001 17:44:44 -0500
Received: from ns.snowman.net ([63.80.4.34]:21000 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S135947AbRAHWoc>;
	Mon, 8 Jan 2001 17:44:32 -0500
Date: Mon, 8 Jan 2001 17:43:56 -0500
From: Stephen Frost <sfrost@snowman.net>
To: Jes Sorensen <jes@linuxcare.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Message-ID: <20010108174355.P26953@ns>
Mail-Followup-To: Jes Sorensen <jes@linuxcare.com>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com
In-Reply-To: <200101080124.RAA08134@pizda.ninka.net> <d366jp4sin.fsf@lxplus015.cern.ch> <200101082148.NAA21738@pizda.ninka.net> <d31yud4qun.fsf@lxplus015.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="33yLIq9/uqwyGAKN"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <d31yud4qun.fsf@lxplus015.cern.ch>; from jes@linuxcare.com on Mon, Jan 08, 2001 at 11:32:48PM +0100
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.2.16 (i686)
X-Uptime: 5:39pm  up 144 days, 21:26,  7 users,  load average: 2.00, 2.00, 2.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--33yLIq9/uqwyGAKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Jes Sorensen (jes@linuxcare.com) wrote:
> >>>>> "David" =3D=3D David S Miller <davem@redhat.com> writes:
>=20
> I don't question Alexey's skills and I have no intentions of working
> against him. All I am asking is that someone lets me know if they make
> major changes to my code so I can keep track of whats happening. It is
> really hard to maintain code if you work on major changes while
> someone else branches off in a different direction without you
> knowing. It's simply a waste of everybody's time.

	Perhaps you missed it, but I believe Dave's intent is for this to
only be a proof-of-concept idea at this time.  These changes are not=20
currently up for inclusion into the mainstream kernel.  I can not think
that Dave would ever just step around a maintainer and submit a patch to
Linus for large changes.

	If many people test these and things work out well for them=20
then I'm sure Dave will go back to the maintainers with the code and=20
the api and work with them to get it into the mainstream kernel. =20
Soliciting ideas and suggestions on how to improve the api and the code=20
paths in the drivers to handle this new method most effectively.

		Stephen

--33yLIq9/uqwyGAKN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6WkKrrzgMPqB3kigRAmokAJ9u4syg08ujQlPVBXuoetDVjJnS6ACeMDj6
B1oHeCXNmDhAVQQmoP+TeGc=
=4/AR
-----END PGP SIGNATURE-----

--33yLIq9/uqwyGAKN--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
