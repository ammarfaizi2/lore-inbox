Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbVA3Tqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVA3Tqk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 14:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVA3Tqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 14:46:40 -0500
Received: from mx1.actcom.net.il ([192.114.47.64]:25795 "EHLO
	smtp1.actcom.co.il") by vger.kernel.org with ESMTP id S261772AbVA3Tqg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 14:46:36 -0500
Date: Sun, 30 Jan 2005 21:48:36 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: linux-kernel@vger.kernel.org
Subject: Re: kbuild: shorthand ym2y, ym2m etc
Message-ID: <20050130194836.GI27006@granada.merseine.nu>
References: <20050130193733.GA8984@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7J16OGEJ/mt06A90"
Content-Disposition: inline
In-Reply-To: <20050130193733.GA8984@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7J16OGEJ/mt06A90
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 30, 2005 at 08:37:33PM +0100, Sam Ravnborg wrote:

> Would that be considered usefull?

IMHO, no. Small languages are only useful when they are more
descriptive than the alternative. In this case, you are replacing two
obvious lines with one entirely not obvious line, causing the Makefile
to become less readable.

Cheers,=20
Muli
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/


--7J16OGEJ/mt06A90
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB/ToUKRs727/VN8sRAtCoAJ4v4qdRZFoUYkjWluHETv6Hno/bGQCdEkJ5
EVVyVJb58AY49nHnRJ4ucmM=
=TcuA
-----END PGP SIGNATURE-----

--7J16OGEJ/mt06A90--
