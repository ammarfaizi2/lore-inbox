Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbUBJWYu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 17:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbUBJWYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 17:24:50 -0500
Received: from mhub-m5.tc.umn.edu ([160.94.23.35]:46794 "EHLO
	mhub-m5.tc.umn.edu") by vger.kernel.org with ESMTP id S261885AbUBJWYr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 17:24:47 -0500
Subject: Re: devfs vs udev, thoughts from a devfs user
From: Matthew Reppert <repp0017@tc.umn.edu>
To: Timothy Miller <miller@techsource.com>
Cc: Mike Bell <kernel@mikebell.org>,
       Chris Friesen <cfriesen@nortelnetworks.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <40293BEB.9010606@techsource.com>
References: <20040210113417.GD4421@tinyvaio.nome.ca>
	 <20040210170157.GA27421@kroah.com> <20040210171337.GK4421@tinyvaio.nome.ca>
	 <40291A73.7050503@nortelnetworks.com>
	 <20040210192456.GB4814@tinyvaio.nome.ca>  <40293BEB.9010606@techsource.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LPmd2TRqYMJHxYcwB5Hv"
Message-Id: <1076451872.21728.25.camel@minerva>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 10 Feb 2004 16:24:32 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LPmd2TRqYMJHxYcwB5Hv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-02-10 at 14:15, Timothy Miller wrote:
>
> If udev had a "devfs" mode where it used a ramdisk for device nodes, and=20
> it produced exactly the same names as devfs, would you be happy with it?

udev ships with several sets of device naming rules, one of which is
meant to create devfs-like names. etc/udev/udev.rules.devfs in the udev
distribution.

Matt

--=-LPmd2TRqYMJHxYcwB5Hv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAKVofA9ZcCXfrOTMRAqfzAKCQLyAvzZR/QMLQr+K8GpKXS9yM9ACdG1Kw
spBbBpHBzg9DpGhLLotMS/I=
=5Wh3
-----END PGP SIGNATURE-----

--=-LPmd2TRqYMJHxYcwB5Hv--

