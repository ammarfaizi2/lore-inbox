Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030363AbWJYNjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbWJYNjZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 09:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030373AbWJYNjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 09:39:25 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:50606 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1030363AbWJYNjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 09:39:24 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: "Marco d'Itri" <md@linux.it>
Subject: Re: major 442
Date: Wed, 25 Oct 2006 15:39:46 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org,
       Greg KH <greg@kroah.com>
References: <20061025102030.GA5790@wonderland.linux.it>
In-Reply-To: <20061025102030.GA5790@wonderland.linux.it>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2662867.01V1AXB44t";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610251539.51952.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2662867.01V1AXB44t
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Mittwoch, 25. Oktober 2006 12:20 schrieb Marco d'Itri:
> I just installed the Debian 2.6.18 kernel package and I noticed that it
> repeatedly tries to load a major 442 module alias, which appears to be
> used by the usb_endpoint devices.
> Does anybody know why? I am not even using the USB ports.

grep 442 /etc/modprobe.conf

HTH

Eike

--nextPart2662867.01V1AXB44t
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFP2knXKSJPmm5/E4RAnjBAJ0WDi7Tpjuo1PT7NIVTqgRgmOF7VgCdG4xJ
Vd1rUd8IC8kXaqjD++Nf7nI=
=1e90
-----END PGP SIGNATURE-----

--nextPart2662867.01V1AXB44t--
