Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbUKBPKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUKBPKz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 10:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUKBN6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 08:58:24 -0500
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:14235 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261972AbUKBMud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 07:50:33 -0500
Message-ID: <41878285.5020702@kolivas.org>
Date: Tue, 02 Nov 2004 23:50:13 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] remove sleep-avg stats
References: <41871BB1.6020001@kolivas.org> <20041102124824.GG15290@elte.hu>
In-Reply-To: <20041102124824.GG15290@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig375D574F2878B5AB3EB52BA5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig375D574F2878B5AB3EB52BA5
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> * Con Kolivas <kernel@kolivas.org> wrote:
> 
> 
>>remove sleep-avg stats
> 
> 
> actually, i'd like to keep this one some more, _especially_ now that we
> are likely to testdrive your patchset in -mm :-)

Ack.

Con

--------------enig375D574F2878B5AB3EB52BA5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBh4KFZUg7+tp6mRURAjK5AJ9OlzoSRhnNgYoPpvZd5QeHvQgvywCglMPN
wMkaXhMdsC8tNIghqLHdXao=
=813a
-----END PGP SIGNATURE-----

--------------enig375D574F2878B5AB3EB52BA5--
