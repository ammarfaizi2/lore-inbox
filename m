Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbULVI46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbULVI46 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 03:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbULVI46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 03:56:58 -0500
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:59880 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261940AbULVI4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 03:56:47 -0500
Message-ID: <41C936C0.5030007@kolivas.org>
Date: Wed, 22 Dec 2004 19:56:32 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Norbert van Nobelen <norbert-kernel@edusupport.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DVD-RW writes but doesn't read
References: <cone.1103672037.983890.28853.502@pc.kolivas.org> <200412220751.46781.norbert-kernel@edusupport.nl>
In-Reply-To: <200412220751.46781.norbert-kernel@edusupport.nl>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9BB57D9949EAC54AD74C75E8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9BB57D9949EAC54AD74C75E8
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Norbert van Nobelen wrote:
> Did you try one of the disks you have written with it in another dvdplayer 
> yet?
> 
> If the written dvds really work, then it is clearly a miracle (-:. The first 
> thing the drive does, is a read action to see if it has an empty disc or 
> something like multisession. If the drive reading is so terrible, that action 
> should fail most of the time too.

Every DVD and CD is perfect. I've burnt about 20.

Con

> On Wednesday 22 December 2004 00:33, you wrote:
> 
>>Hi Jens et al
>>
>>I have a laptop DVD-RW that is working fine when burning but has endless
>>streams of errors with any kernel I try when trying to read anything
>>(cd/dvd audio/video/data).
>>
>>hdc: command error: status=0x51 { DriveReady SeekComplete Error }
>>hdc: command error: error=0x50
>>ide: failed opcode was 100
>>end_request: I/O error, dev hdc, sector 571832
>>Buffer I/O error on device hdc, logical block 71479
>>
>>If I'm persistent I can read the data off the drive but I'll probably
>>kill the drive in the process. It doesn't matter what iosched I use but I
>>use cfq by default. I've tried disabling dma and so on without success. Any
>>ideas?

--------------enig9BB57D9949EAC54AD74C75E8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFByTbCZUg7+tp6mRURAkJvAKCQUhxBhu4yLIpPkGPXRWz1kg0KxACeO84r
NPMLQGY0hPzssUKo7cyPntA=
=1AxL
-----END PGP SIGNATURE-----

--------------enig9BB57D9949EAC54AD74C75E8--
