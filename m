Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbVCCKCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbVCCKCF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 05:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbVCCKCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 05:02:05 -0500
Received: from harmonie.imag.fr ([147.171.130.40]:46721 "EHLO harmonie.imag.fr")
	by vger.kernel.org with ESMTP id S262179AbVCCKBz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:01:55 -0500
Message-ID: <4226EE85.3030202@naurel.org>
Date: Thu, 03 Mar 2005 12:01:25 +0100
From: =?UTF-8?B?QXVyw6lsaWVuIEZyYW5jaWxsb24=?= <aurel@naurel.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050117)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Gruenbacher <agruen@suse.de>
CC: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Olaf Kirch <okir@suse.de>
Subject: Re: 2.6.11-rc5-mm1
References: <20050301012741.1d791cd2.akpm@osdl.org>	 <4224A905.7060801@naurel.org>  <20050302005344.1c3420db.akpm@osdl.org> <1109778352.22077.155.camel@winden.suse.de>
In-Reply-To: <1109778352.22077.155.camel@winden.suse.de>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFD06DFC3550B95DC3E4A4AD1"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (harmonie.imag.fr [147.171.130.40]); Thu, 03 Mar 2005 11:01:27 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-MailScanner-From: aurel@naurel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFD06DFC3550B95DC3E4A4AD1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Andreas Gruenbacher wrote:
> Hello,
>=20
> On Wed, 2005-03-02 at 09:53, Andrew Morton wrote:
>=20
>>Aur=C3=A9lien Francillon <aurel@naurel.org> wrote:
>>
>>>[...]
>>>cvs diff Makefile=20
>>>             cvs diff: cannot create read lock in repository=20
>>>`/mnt/iseran/roca/cvsroot/ldpc': No such file or directory
>>>cvs [diff aborted]: read lock failed - giving up
>>>
>>>but the file is created and i can "cat " it without problem ...
>=20
>=20
> This fixes it:


yes, no more problems with nfs
thank you !
	Aur=C3=A9lien

--=20
Lat:     45:11:43N (45.1954)
Lon:      5:43:36E ( 5.7268)


--------------enigFD06DFC3550B95DC3E4A4AD1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCJu6FtsnPPsovZP0RAodnAJ9gH8DY6SxJmewuCM+1O7x9EMdaQwCffYX7
PK01emCArqXos0bNTdrARVA=
=gKkP
-----END PGP SIGNATURE-----

--------------enigFD06DFC3550B95DC3E4A4AD1--
