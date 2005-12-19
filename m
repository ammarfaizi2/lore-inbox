Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965030AbVLSXJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbVLSXJI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 18:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbVLSXJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 18:09:08 -0500
Received: from mail.gmx.de ([213.165.64.21]:44236 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965030AbVLSXJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 18:09:07 -0500
X-Authenticated: #5082238
Date: Tue, 20 Dec 2005 00:09:07 +0100
From: Carsten Otto <c-otto@gmx.de>
To: "Bonilla, Alejandro" <alejandro.bonilla@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Intel e1000 fails after RAM upgrade
Message-ID: <20051219230907.GA17046@carsten-otto.halifax.rwth-aachen.de>
Reply-To: c-otto@gmx.de
Mail-Followup-To: "Bonilla, Alejandro" <alejandro.bonilla@hp.com>,
	linux-kernel@vger.kernel.org
References: <F265D57E1F28274EA189ED0566D227DE816FE7@PGJEXC01.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <F265D57E1F28274EA189ED0566D227DE816FE7@PGJEXC01.americas.cpqcorp.net>
X-GnuGP-Key: http://c-otto.de/pubkey.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 19, 2005 at 04:49:58PM -0600, Bonilla, Alejandro wrote:
> I remember a problem with the 100Ve and the 1000MT giving issues when it
> is a LOM or even a PCI adapter. I used to fix a lot of these problems by
> removing all power from the board molex, maybe the "battery" on the
> mother board for some minutes and then plug-in everything back in.

I carried the card around the house for some minutes (although the
computer had power for most of the time). I will try a bios reset
(without battery) now.

The kernel downgrade did not help.

e1000: eth0: e1000_reg_test: pattern test reg 0028 failed: got
0xA5A585A5 expected 0xA5A5A5A5

This is shown when testing with ethtool.

Bye,
--=20
Carsten Otto
c-otto@gmx.de
www.c-otto.de

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDpz2TjUF4jpCSQBQRAhsfAKDwTTdyGyOOzQSgfBQPGnZ5OaJPrwCg8u10
Gp6OcJ9lDILzTURFeib5mjM=
=bITv
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
