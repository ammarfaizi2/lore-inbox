Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269624AbUJWAle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269624AbUJWAle (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 20:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269386AbUJWAiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 20:38:19 -0400
Received: from mail10.syd.optusnet.com.au ([211.29.132.191]:46748 "EHLO
	mail10.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S269388AbUJWAgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 20:36:05 -0400
Message-ID: <4179A763.9040603@kolivas.org>
Date: Sat, 23 Oct 2004 10:35:47 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: markus@trippelsdorf.net, linux-kernel@vger.kernel.org
Subject: Re: BT848 video support dropped in 2.6.9?
References: <1098447230.12289.12.camel@localhost>	<4178FAB4.9070208@kolivas.org> <20041022173214.5bc8c316.akpm@osdl.org>
In-Reply-To: <20041022173214.5bc8c316.akpm@osdl.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB0E7C396D112F07AF44D5117"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB0E7C396D112F07AF44D5117
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> 
>>Markus Trippelsdorf wrote:
>>
>>>The "BT848 video for linux" item does not show up
>>>with menuconfig in the "Video for linux" category.
>>>It was there in all previous kernels that I've used.
>>>Am I missing something obvious?
>>
>>config VIDEO_BT848
>>	depends on VIDEO_DEV && PCI && I2C && FW_LOADER
> 
> 
> Or you can do `make menuconfig' then hit "/BT848".  I love that feature!

Now _that_ is cool! I wish I had known about that a long time ago.

Cheers,
Con

--------------enigB0E7C396D112F07AF44D5117
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBeadjZUg7+tp6mRURAq19AJ91j4qlHAl6pQrsTLecLzQw1nojrQCeICbA
RLEh/K2v/oNDZy1oBpBJkN4=
=9MER
-----END PGP SIGNATURE-----

--------------enigB0E7C396D112F07AF44D5117--
