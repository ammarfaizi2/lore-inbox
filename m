Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265042AbUFMLTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265042AbUFMLTx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 07:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265043AbUFMLTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 07:19:52 -0400
Received: from 216-229-91-229-empty.fidnet.com ([216.229.91.229]:37640 "EHLO
	mail.icequake.net") by vger.kernel.org with ESMTP id S265042AbUFMLTv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 07:19:51 -0400
Date: Sun, 13 Jun 2004 06:19:49 -0500
From: Ryan Underwood <nemesis-lists@icequake.net>
To: linux-kernel@vger.kernel.org
Subject: Request: Netmos support in parport_serial for 2.4.27
Message-ID: <20040613111949.GB6564@dbz.icequake.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

There's been a patch floating around for a while now to add Netmos
support to parport_serial.  It has been submitted numerous times but it
seems that nobody notices it. :)

Can it be reviewed for inclusion before 2.4.27?  I have a few systems
with these cards and it would be very nice to have them up to snuff.

The patch against 2.4.20 can be found here:
http://winterwolf.co.uk/linuxsw

--=20
Ryan Underwood, <nemesis@icequake.net>

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAzDhVIonHnh+67jkRAmoXAKCaHLPbbB68d3w204Lx4l1eQUaGJACeKNvU
d7kZvl+jpSGlEZd23lO+yVc=
=jy/7
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
