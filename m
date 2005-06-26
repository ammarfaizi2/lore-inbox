Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVFZCYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVFZCYK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 22:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbVFZCYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 22:24:10 -0400
Received: from mxout03.versatel.de ([212.7.152.117]:55459 "EHLO
	mxout03.versatel.de") by vger.kernel.org with ESMTP id S261446AbVFZCYC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 22:24:02 -0400
Message-ID: <42BE11B5.1020402@web.de>
Date: Sun, 26 Jun 2005 04:23:49 +0200
From: Christian Trefzer <ctrefzer@web.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050617)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: -mm -> 2.6.13 merge status
References: <20050620235458.5b437274.akpm@osdl.org.suse.lists.linux.kernel> <p73d5qgc67h.fsf@verdi.suse.de> <42B86027.3090001@namesys.com> <20050621195642.GD14251@wotan.suse.de> <42B8C0FF.2010800@namesys.com> <84144f0205062223226d560e41@mail.gmail.com> <42BB0151.3030904@suse.de> <87fyv8h80y.fsf@evinrude.uhoreg.ca> <42BDFA8E.6060608@web.de> <42BE0151.7010606@namesys.com>
In-Reply-To: <42BE0151.7010606@namesys.com>
X-Enigmail-Version: 0.92.0.0
OpenPGP: id=6B99E3A5
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig566D91FB0838F110136A2B31"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig566D91FB0838F110136A2B31
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hans Reiser schrieb:
> Christian Trefzer wrote:
> 
> 
>>Hubert Chan schrieb:
>>
>>
>>>How about something of the form "nikita-955(file:line)"?  Or the
>>>reverse: "file:line(nikita-955)".  Would that keep everyone happy?
>>>
> 
> Makes me happy.....
> 

Nice, how about the others?

Hey, if we need some objective and neutral mediators on lkml, I'd be 
glad to give my reading frenzies a meaning : )

--------------enig566D91FB0838F110136A2B31
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQr4RuF2m8MprmeOlAQKyuRAAskisvOsZxWMcuEJRTB9Mx00fPT6oZcZr
BIWxvaA37XpNE9uZKNMpfFlah7e56+iq8pXtSRIB8a9604eXGoxQ6G6BZB8B3huz
PS9dIE8II+q7G7wHexpJg/5ZpFDHHT0Fd+0J2dEbbKVJB52yIFtZkvkcIZ5BDvQW
sgcxO4jH8a+/kmgBm30XLfoiTJ9XfaHg5jee9Vc1oG17fO9Lq3QXYhNUIlVpU0+w
2Z+Bf5UB5i6RFmTXM7TTdhp+LRjdLw9VN11w2RvWg4GjWmdmAtmHSl95NT4A11UB
vw/QNCQXEHqIwC4jG0j5+5YpqhzS8UShZPDwmyX7izPmrILyamG5fH7zBMEOqhGt
4D+x6jjyQKlLXxJgai1i4AXq3IrQ81fGJb4LTdCnZ/oGlWKY0iC/MHJG+bRXL/Nx
NeQXIBXvCJZByLLpTv8TvJAs/96FVO+EgFe9du+QLJAdjeZLAspIarhz+1QnaS92
9rxZL6QNFa5z8kTOTzeB+RE5xlqq4Y0xPa5Ymb67TwdtzyNgxB/A6lM4+6FlTu6G
U01cds3cSBDATG0oQKg8cBTA9rw5ibuw2sniUxfafKUJAU4rpm4XFj0uyiTxj+Qx
CRGlNeodiTvv4nsoB5q3rjoLlVRouDdlBMRS7WLDLBowDoNz3pnpFd52Yj/2s3vQ
OGFowZ9Z0do=
=ibMZ
-----END PGP SIGNATURE-----

--------------enig566D91FB0838F110136A2B31--
