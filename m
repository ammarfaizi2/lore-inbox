Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161204AbWF0Quc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161204AbWF0Quc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161203AbWF0Qub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:50:31 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:35532 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1161200AbWF0Qu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:50:29 -0400
Message-ID: <44A161CC.4060002@zurich.ibm.com>
Date: Tue, 27 Jun 2006 18:50:20 +0200
From: dirk husemann <hud@zurich.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060607)
MIME-Version: 1.0
CC: Pavel Machek <pavel@ucw.cz>, suspend2-devel@lists.suspend2.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [Suspend2-devel] Re: Suspend2 - Request for review & inclusion
 in	-mm
References: <200606270147.16501.ncunningham@linuxmail.org>	<20060627133321.GB3019@elf.ucw.cz> <44A14D3D.8060003@wasp.net.au>
In-Reply-To: <44A14D3D.8060003@wasp.net.au>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0703A492495508AF57FD9B25"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0703A492495508AF57FD9B25
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Brad Campbell wrote:
> Pavel Machek wrote:
>>> Some of the advantages of suspend2 over swsusp and uswsusp are:
>>>
>>> - Speed (Asynchronous I/O and readahead for synchronous I/O)
>>
>> uswsusp should be able to match suspend2's speed. It can do async I/O,=

>> etc...
>
> ARGH!
>
> And the next version of windows will have all the wonderful features
> that MacOSX has now so best not upgrade to Mac as you can just wait
> for the next version of windows.
>
> suspend2 has it *now*. It works, it's stable.
exactly my sentiments!! IT JUST WORKS! NOW!
>
> uswsusp is a great idea, really.. I love it.. but suspend2 is here, it
> works, it's stable and it's now. Why continue to deprive the
> mainstream of these features because "uswsusp should".. as yet it
> doesn't..
<soapbox>
and i'm sick and tired of waiting for the pot of suspend gold at the end
of the kernel rainbow that will eventually be available...could we
include suspend2 now while the world waits with bated breath for uswsusp
to emerge?
</soapbox>


--=20
Dr Dirk Husemann, Pervasive Computing, IBM Research, Zurich Research Lab
	hud@zurich.ibm.com --- http://www.zurich.ibm.com/~hud/
       PGP key: http://www.zurich.ibm.com/~hud/contact/PGP
  PGP Fingerprint: 983C 48E7 0A78 A313 401C  C4AD 3C0A 278E 6431 A149
	     Email only authentic if signed with PGP key.

Appended to this email is an electronic signature attachment. You can
ignore it if your email program does not know how to verify such a
signature. If you'd like to learn more about this topic, www.gnupg.org
is a good starting point.



--------------enig0703A492495508AF57FD9B25
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEoWHPPAonjmQxoUkRAp8GAJ9qMJbGCmKwfFiNx4B9L691ojnTbgCgpc3y
OncwhSnWI7WXOOBVgKu9iDA=
=ReTo
-----END PGP SIGNATURE-----

--------------enig0703A492495508AF57FD9B25--
