Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264047AbRFERSR>; Tue, 5 Jun 2001 13:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264049AbRFERSH>; Tue, 5 Jun 2001 13:18:07 -0400
Received: from mail-smtp.socket.net ([216.106.1.32]:14608 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S264047AbRFERRx>; Tue, 5 Jun 2001 13:17:53 -0400
Date: Tue, 5 Jun 2001 12:17:25 -0500
From: "Gregory T. Norris" <haphazard@socket.net>
To: "paolo.pedroni@iol.it" <paolo.pedroni@iol.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Agpgart for AMD761
Message-ID: <20010605121725.A15753@glitch.snoozer.net>
Mail-Followup-To: "paolo.pedroni@iol.it" <paolo.pedroni@iol.it>,
	linux-kernel@vger.kernel.org
In-Reply-To: <GEGK5H$IXkNoE_FHJoeiOHXWLjWb2HtA2ZGSm7PCRGtuESl_JfV2caz@iol.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <GEGK5H$IXkNoE_FHJoeiOHXWLjWb2HtA2ZGSm7PCRGtuESl_JfV2caz@iol.it>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux glitch 2.4.5 #1 Thu May 31 18:23:54 CDT 2001 i686 unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It seems to be working just fine here (kernel 2.4.5), provided that the
"agp_try_unsupported=3D1" option is specified.  This tells the driver to
assume that it behaves like known chipsets from the same vendor.


On Tue, Jun 05, 2001 at 03:00:53PM +0200, paolo.pedroni@iol.it wrote:
> I was wondering what is the state of support for the AMD761 Northbridge=
=20
> chip, especially regarding agp operations since I don't see it listed=20
> in the kernel configuration for the AGPGart device.
> Please CC any answer to my address, since I'm not subscribed to the=20
> list.
> Thanks in advance.
>=20
> Paolo Pedroni

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7HRQlgrEMyr8Cx2YRAlEYAKCI+HdOmQfdhhkXcZq2rxxdqoUYDgCeO3Z+
AOJHGiqbcGWsepTn1sAZq+A=
=6KDh
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
