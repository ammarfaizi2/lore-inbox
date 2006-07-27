Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751719AbWG0PRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbWG0PRg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 11:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbWG0PRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 11:17:36 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:8641 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1751719AbWG0PRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 11:17:36 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: "Brian D. McGrew" <brian@visionpro.com>
Subject: Re: Building the kernel on an SMP box?
Date: Thu, 27 Jul 2006 17:19:23 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <14CFC56C96D8554AA0B8969DB825FEA0012B3898@chicken.machinevisionproducts.com>
In-Reply-To: <14CFC56C96D8554AA0B8969DB825FEA0012B3898@chicken.machinevisionproducts.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1995013.xQxMXdvX8s";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607271719.37097.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1995013.xQxMXdvX8s
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> And then to go to the extreme, what kind of horsepower should I be
> looking for if I want get the build times down to say a minute or so???

The machine where I reached the one minute limit was a 16x 2,7Ghz Xeon HT w=
ith=20
32GB of RAM. The good thing is I had to pay neither the machine nor the pow=
er=20
bill for it :)

Eike

--nextPart1995013.xQxMXdvX8s
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBEyNmJXKSJPmm5/E4RAkJ3AKCHCppOu6EdPe/p4YgYWGVxJFfWTACfcjih
/uTzR0GVPXnP0wUXp0oVxFw=
=tQ7A
-----END PGP SIGNATURE-----

--nextPart1995013.xQxMXdvX8s--
