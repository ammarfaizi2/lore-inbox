Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129423AbQLOAR1>; Thu, 14 Dec 2000 19:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131370AbQLOARK>; Thu, 14 Dec 2000 19:17:10 -0500
Received: from ns.snowman.net ([63.80.4.34]:51210 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S129423AbQLOAQs>;
	Thu, 14 Dec 2000 19:16:48 -0500
Date: Thu, 14 Dec 2000 18:45:44 -0500
From: Stephen Frost <sfrost@snowman.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Netfilter <netfilter@us5.samba.org>
Subject: Re: test13-pre1 changelog
Message-ID: <20001214184544.O26953@ns>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Netfilter <netfilter@lists.samba.org>
In-Reply-To: <3A392852.B9B64C7F@the-rileys.net> <91bl9a$cc4$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLRDCdsRrCd4mzuj"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <91bl9a$cc4$1@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Dec 14, 2000 at 03:31:54PM -0800
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.2.16 (i686)
X-Uptime: 6:44pm  up 119 days, 22:34,  7 users,  load average: 2.04, 2.01, 2.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLRDCdsRrCd4mzuj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Linus Torvalds (torvalds@transmeta.com) wrote:
>=20
> Especially if we get that netfilter problem sorted out (see the other
> thread about the IP fragmentation issues associated with that one), and
> if we figure out why apparently some people have trouble with external
> modules (at least one person has trouble with loading alsa modules).=20

	Any idea if these issues would cause a general slow-down of a
machine?  For no apparent reason after 5 days running 2.4.0test12
everything going through my firewall (set up using iptables) I got about
100ms time added on to pings and traceroutes.  I'll probably reboot the
machine tonight and see if that helps.

		Stephen

--SLRDCdsRrCd4mzuj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6OVunrzgMPqB3kigRAmt/AJ4g3iFUxRgcIrrhnYB8OctSt4NJPwCglKtt
uKxLjawiQHT7fxW33PO/a1c=
=b+d+
-----END PGP SIGNATURE-----

--SLRDCdsRrCd4mzuj--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
