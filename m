Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVC0TnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVC0TnM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 14:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVC0TnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 14:43:11 -0500
Received: from mail.sf-mail.de ([62.27.20.61]:34251 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S261491AbVC0TnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 14:43:06 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] typo fix in Documentation/eisa.txt
Date: Sun, 27 Mar 2005 21:45:04 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
References: <200503271554.44382.eike-kernel@sf-tec.de> <20050327213124.1e82828b.khali@linux-fr.org>
In-Reply-To: <20050327213124.1e82828b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7893686.nynjYDxqxu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200503272145.10266.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart7893686.nynjYDxqxu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Jean Delvare wrote:
> Hi Eike,
>
> > Trivial typo fix.
> > (...)
> >  Force the probing code to probe EISA slots even when it cannot find an
> > -EISA compliant mainboard (nothing appears on slot 0). Defaultd to 0
> > +EISA compliant mainboard (nothing appears on slot 0). Default to 0
> >  (don't force), and set to 1 (force probing) when either
> >  CONFIG_ALPHA_JENSEN or CONFIG_EISA_VLB_PRIMING are set.
>
> Wouldn't it rather be "Defaults"?

Damn, yes. Every time I read it again I feel a little bit more comfortable=
=20
with s/are set/is set/. Am I right or is it already too late for useful=20
work?

Eike

--nextPart7893686.nynjYDxqxu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCRw1GXKSJPmm5/E4RAtaDAJ9l2ApZByC8Hsq2P0jbx6Cm6/7Y9gCfQp2I
MBvqsaoTAKHfV/NZC9dyU6g=
=Q2Mb
-----END PGP SIGNATURE-----

--nextPart7893686.nynjYDxqxu--
