Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751550AbWIRNlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbWIRNlm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 09:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbWIRNlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 09:41:42 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:62678 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1751550AbWIRNlm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 09:41:42 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Greg KH <greg@kroah.com>
Subject: Re: Exporting array data in sysfs
Date: Mon, 18 Sep 2006 15:41:45 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <200609181359.31489.eike-kernel@sf-tec.de> <20060918124425.GA8304@kroah.com>
In-Reply-To: <20060918124425.GA8304@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2670495.kQ6Aykhtfi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609181541.57164.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2670495.kQ6Aykhtfi
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Greg KH wrote:
> On Mon, Sep 18, 2006 at 01:59:17PM +0200, Rolf Eike Beer wrote:
> > Hi,
> >
> > I would like to put the contents of an array in sysfs files. I found no
> > simple way to do this, so here are my thoughts in hope someone can hand
> > me a light.
>
> What is wrong with using an attribute group for this kind of
> information?

Missing documentation. Yes, this looks like I could use this at least for t=
he=20
simple interfaces (which would be enough).

Eike


--nextPart2670495.kQ6Aykhtfi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFDqIlXKSJPmm5/E4RAqWuAKCL9pbSf46ZXsA6ewvy0tDck0x34ACfVZLs
5xHGDzMzifO3f5M1+cDN0Z4=
=C+cO
-----END PGP SIGNATURE-----

--nextPart2670495.kQ6Aykhtfi--
