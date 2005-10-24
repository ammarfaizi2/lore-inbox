Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbVJXO71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbVJXO71 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 10:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbVJXO71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 10:59:27 -0400
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:44694 "EHLO
	smtprelay03.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751069AbVJXO70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 10:59:26 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org, paulmck@us.ibm.com
Subject: Re: [PATCH] RCU torture-testing kernel module
Date: Mon, 24 Oct 2005 16:59:13 +0200
User-Agent: KMail/1.7.2
References: <20051022231214.GA5847@us.ibm.com> <20051023120521.26031051.akpm@osdl.org> <20051024004709.GA9454@us.ibm.com>
In-Reply-To: <20051024004709.GA9454@us.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1440239.H4RIMtsFIh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510241659.19386.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1440239.H4RIMtsFIh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Paul,

On Monday 24 October 2005 02:47, Paul E. McKenney wrote:
> OK, the attached patch covers this and also fixes the redundant #include
> that Greg KH spotted.
>=20
> Thoughts?

Wonderful. Great job!


Regards

Ingo Oeser


--nextPart1440239.H4RIMtsFIh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDXPbHU56oYWuOrkARAhFRAKDPIL8ve08f+nOgr93WdQmUUsFw3QCg36jI
197H98tmsl5EdK045sBaC9o=
=DuI7
-----END PGP SIGNATURE-----

--nextPart1440239.H4RIMtsFIh--
