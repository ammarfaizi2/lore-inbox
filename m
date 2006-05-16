Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751555AbWEPGtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbWEPGtW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 02:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbWEPGtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 02:49:21 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:25497 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751552AbWEPGtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 02:49:21 -0400
Message-ID: <446975DF.3010408@t-online.de>
Date: Tue, 16 May 2006 08:49:03 +0200
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: acpi_power_off doesn't
References: <6cPPS-7BT-33@gated-at.bofh.it> <6d08v-5T4-15@gated-at.bofh.it> <4469649A.80203@shaw.ca>
In-Reply-To: <4469649A.80203@shaw.ca>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAE23A785498A9C88FF27DDFE"
X-ID: Z4BktTZdoe5FKCzue7Qd8zEdsRjkIzw+l9QD5bmL61lLWUrRJ3Gvsw
X-TOI-MSGID: 266624b3-ab7c-4917-abc6-c4f5c94db8f2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAE23A785498A9C88FF27DDFE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Robert,

Robert Hancock wrote:
>=20
> Do you get any ACPI execution errors, etc. in the dmesg output after th=
e
> system has been running for a while? I've seen this happen after the
> ACPI machinery gets into a bad state..
>=20
Nothing suspicious, as it seems. If I grep -i acpi in syslog, then I get:=


May 15 13:09:11 bugs kernel: ACPI: PCI Interrupt 0000:00:1b.0[A] -> Link =
[LNKA] -> GSI 10 (level, low) -> IRQ 10
May 15 13:09:11 bugs kernel: ACPI: Power Button (FF) [PWRF]
May 15 13:09:11 bugs kernel: ACPI: Power Button (CM) [PWRB]
May 15 13:13:11 bugs kernel: ACPI: PCI Interrupt 0000:00:1b.0[A] -> Link =
[LNKA] -> GSI 10 (level, low) -> IRQ 10
May 15 13:13:11 bugs kernel: ACPI: Power Button (FF) [PWRF]
May 15 13:13:11 bugs kernel: ACPI: Power Button (CM) [PWRB]
May 15 13:18:52 bugs kernel: ACPI: Power Button (FF) [PWRF]
May 15 13:18:52 bugs kernel: ACPI: Power Button (CM) [PWRB]
May 15 13:22:46 bugs kernel: ACPI: PCI Interrupt 0000:00:1b.0[A] -> Link =
[LNKA] -> GSI 10 (level, low) -> IRQ 10
May 15 13:22:46 bugs kernel: ACPI: Power Button (FF) [PWRF]
May 15 13:22:46 bugs kernel: ACPI: Power Button (CM) [PWRB]
May 15 13:26:40 bugs kernel: ACPI: PCI Interrupt 0000:00:1b.0[A] -> Link =
[LNKA] -> GSI 10 (level, low) -> IRQ 10
May 15 13:26:40 bugs kernel: ACPI: Power Button (FF) [PWRF]
May 15 13:26:40 bugs kernel: ACPI: Power Button (CM) [PWRB]
May 15 13:51:58 bugs kernel: ACPI: PCI Interrupt 0000:01:00.0[A] -> Link =
[LNKA] -> GSI 10 (level, low) -> IRQ 10
May 15 14:00:50 bugs kernel: ACPI: PCI Interrupt 0000:00:1b.0[A] -> Link =
[LNKA] -> GSI 10 (level, low) -> IRQ 10
May 15 14:00:50 bugs kernel: ACPI: Power Button (FF) [PWRF]
May 15 14:00:50 bugs kernel: ACPI: Power Button (CM) [PWRB]
May 15 14:01:24 bugs kernel: ACPI: PCI Interrupt 0000:01:00.0[A] -> Link =
[LNKA] -> GSI 10 (level, low) -> IRQ 10
May 15 19:08:02 bugs kernel: ACPI: PCI Interrupt 0000:00:1b.0[A] -> Link =
[LNKA] -> GSI 10 (level, low) -> IRQ 10
May 15 19:08:02 bugs kernel: ACPI: Power Button (FF) [PWRF]
May 15 19:08:02 bugs kernel: ACPI: Power Button (CM) [PWRB]
May 15 19:16:45 bugs kernel: ACPI: PCI Interrupt 0000:00:1b.0[A] -> Link =
[LNKA] -> GSI 10 (level, low) -> IRQ 10
May 15 19:16:46 bugs kernel: ACPI: Power Button (FF) [PWRF]
May 15 19:16:46 bugs kernel: ACPI: Power Button (CM) [PWRB]
May 15 20:36:35 bugs kernel: ACPI: PCI Interrupt 0000:01:00.0[A] -> Link =
[LNKA] -> GSI 10 (level, low) -> IRQ 10


Regards

Harri



--------------enigAE23A785498A9C88FF27DDFE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEaXXqUTlbRTxpHjcRAorgAJ40si2cC6H7ZB6p9uIJTTN9HT4L7ACfaXAQ
zeZFDpCp4NEhhyFQ3A1Y1NQ=
=c3ji
-----END PGP SIGNATURE-----

--------------enigAE23A785498A9C88FF27DDFE--
