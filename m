Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264934AbUAAWOt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 17:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264604AbUAAWM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 17:12:26 -0500
Received: from neveragain.de ([217.69.76.1]:20166 "EHLO hobbit.neveragain.de")
	by vger.kernel.org with ESMTP id S264902AbUAAWJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 17:09:40 -0500
Date: Thu, 1 Jan 2004 23:09:33 +0100
From: Martin Loschwitz <madkiss@madkiss.org>
To: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: ACPI related problems with Linux 2.6.1-rc1-mm1
Message-ID: <20040101220933.GB1804@minerva.local.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello again,

I'm writing this mail as I'm discovering ACPI related problems on my Acer=
=20
TravelMate 800LCi notebook with Linux 2.6.1-rc1-mm1.

While the system boots up fine with Linux 2.6.1-rc1, with 2.6.1-rc1-mm1 it
hangs while booting. The last message printed to screen is "ACPI: IRQ 9=20
was Edge Triggered, setting to Level Triggerd". This is fully reproducable=
=20
with a Linux 2.6.0 kernel which has the ACPI20031203 patch applied.

Just for the records, with 2.6.1-rc1, the message that comes right after
the "ACPI: IRQ 9 ..." message is:

evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successf=
ul

Is this a known problem and if so is a fix available?

--=20
  .''`.   Martin Loschwitz           Debian GNU/Linux developer
 : :'  :  madkiss@madkiss.org        madkiss@debian.org
 `. `'`   http://www.madkiss.org/    people.debian.org/~madkiss/
   `-     Use Debian GNU/Linux 3.0!  See http://www.debian.org/

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/9JqdHPo+jNcUXjARAsbrAJ9y2a1ajnvgbyvK6lHpYnODeY95XACgoXkd
A1Tz2rnfBVd2n1VW1Ps2vJc=
=xvt9
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
