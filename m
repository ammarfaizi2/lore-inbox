Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbTDFPZt (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 11:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbTDFPZt (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 11:25:49 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:60355 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S263018AbTDFPZq (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 11:25:46 -0400
Date: Sun, 6 Apr 2003 18:37:13 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: poweroff problem
Message-Id: <20030406183713.3435d742.us15@os.inf.tu-dresden.de>
In-Reply-To: <1049639095.963.0.camel@dhcp22.swansea.linux.org.uk>
References: <20030405060804.31946.qmail@webmail5.rediffmail.com>
	<20030406233319.042878d3.sfr@canb.auug.org.au>
	<20030406155814.68c5c908.us15@os.inf.tu-dresden.de>
	<20030407002703.16993dc4.sfr@canb.auug.org.au>
	<20030406174655.592b7f60.us15@os.inf.tu-dresden.de>
	<1049639095.963.0.camel@dhcp22.swansea.linux.org.uk>
Organization: Disorganized
X-Mailer: Sylpheed version 0.8.11claws3 (GTK+ 1.2.10; Linux 2.4.21-pre6)
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.TFa5Fk+Mn?wx+3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.TFa5Fk+Mn?wx+3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 06 Apr 2003 15:24:55 +0100 Alan Cox (AC) wrote:

AC> We rely on the bios for the power off sequences. Many BIOS vendors do
AC> set it up to share the bios code it seems

Ok, but this does not explain why things work with 2.5.66 on the exact same
machine, unless 2.5 had workarounds for BIOS bugs or didn't use the BIOS for
power off. Board is an Asus A7V, BIOS version 1011.

-Udo.

--=.TFa5Fk+Mn?wx+3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.1 (GNU/Linux)

iD8DBQE+kFe5nhRzXSM7nSkRAqvYAJ4roEOkJC8hVcL9UaKlnTCVV34J2gCfUGQt
BLQpK5nLK7SrJ0q9u1Vr2HM=
=nZV1
-----END PGP SIGNATURE-----

--=.TFa5Fk+Mn?wx+3--
