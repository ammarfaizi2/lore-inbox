Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130374AbRANMIX>; Sun, 14 Jan 2001 07:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132279AbRANMIN>; Sun, 14 Jan 2001 07:08:13 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:61012 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S130374AbRANMIC>; Sun, 14 Jan 2001 07:08:02 -0500
Date: Sun, 14 Jan 2001 12:07:59 +0000
From: Tim Waugh <twaugh@redhat.com>
To: LAMBERT Bernard <bga.lambert@wanadoo.fr>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: lp with kernel 2.2.18
Message-ID: <20010114120759.A7887@redhat.com>
In-Reply-To: <3A615D6D.AF2E8982@wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A615D6D.AF2E8982@wanadoo.fr>; from bga.lambert@wanadoo.fr on Sun, Jan 14, 2001 at 09:03:57AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Looks like you didn't configure your kernel with printer support.  You
want CONFIG_PRINTER.

Tim.
*/

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6YZaeONXnILZ4yVIRAorqAJ9ccTse9cwRE8/YuQzPYcamXvx46gCdGUOy
/mwVrtFP2aPMPTdUrWEZAI0=
=36Yn
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
