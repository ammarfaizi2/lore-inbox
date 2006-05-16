Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWEPFNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWEPFNa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 01:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWEPFNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 01:13:30 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:40358 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751300AbWEPFN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 01:13:29 -0400
Message-ID: <44695F67.5030805@t-online.de>
Date: Tue, 16 May 2006 07:13:11 +0200
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: "Brown, Len" <len.brown@intel.com>
CC: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: acpi_power_off doesn't
References: <CFF307C98FEABE47A452B27C06B85BB670FB98@hdsmsx411.amr.corp.intel.com>
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB670FB98@hdsmsx411.amr.corp.intel.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA32014FBC63640D13A0C5E6C"
X-ID: ZefOYaZJYerNJza2U1iyZcbb5pWr7yt0Cm9C44ut-qudZbOsNLWekm
X-TOI-MSGID: 04e6a576-0557-4ff9-94b2-7dcd77499935
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA32014FBC63640D13A0C5E6C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi Len,

The problem does not exist, if I boot my PC and then
halt it immediately. If I login and use it for some
time, then acpi_power_off does not work.

Box 'X' is an Aopen MZ-915M, CPU is a 2 GHz Pentium
M. It is running Debian Sid, kernel is vanilla

Linux bugs 2.6.17-rc4 #1 PREEMPT Sat May 13 16:22:54 CEST 2006 i686 GNU/L=
inux

Old kernels don't work on this PC due to missing
hardware support. The first vanilla kernel that worked
reliably on this box (except for acpi_power_off) was 2.6.16.


Regards

Harri
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Brown, Len wrote:
>> Sometimes when I run 'halt' my PC does not go off. Last
>> words are
>>
>> 	acpi_power_off called
>>
>> But the PC stays on.
>>
>> What is the story here? I've seen this problem come up
>> several times, but without solution, as it seems. Any
>> hint would be very helpfull.
>=20
> Does this happen all the time, or just some of the time?
> Has this always failed on box X, or did it used to
> work in some release Y, and broke in some release Z?
>=20
> Please supply X, Y, Z.
>=20
> thanks,
> -Len
>=20



--------------enigA32014FBC63640D13A0C5E6C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEaV9xUTlbRTxpHjcRArZmAJwNxcexbe0i1ES7COXZ9xT6YdEAjwCgh4VP
S0SHsWy+s+9nn1p2Tyk9ZBA=
=+Tp/
-----END PGP SIGNATURE-----

--------------enigA32014FBC63640D13A0C5E6C--
