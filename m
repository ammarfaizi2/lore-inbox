Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbUJWXDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbUJWXDu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 19:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbUJWXDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 19:03:50 -0400
Received: from mail14.syd.optusnet.com.au ([211.29.132.195]:22440 "EHLO
	mail14.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261330AbUJWXDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 19:03:42 -0400
Message-ID: <417AE332.6090300@kolivas.org>
Date: Sun, 24 Oct 2004 09:03:14 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Javier Marcet <javier@marcet.info>, linux-kernel@vger.kernel.org
Subject: Re: Mem issues in 2.6.9 (ever since 2.6.9-rc3) and possible cause
References: <20041023125948.GC9488@marcet.info> <20041023123323.04b59353.akpm@osdl.org>
In-Reply-To: <20041023123323.04b59353.akpm@osdl.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig28ED3D53887F7505506B965B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig28ED3D53887F7505506B965B
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Javier Marcet <javier@marcet.info> wrote:
> 
>>I've been following quite closely the development of 2.6.9, testing
>> every -rc release and a lot of -bk's.
>>
>> Upon changing from 2.6.9-rc2 to 2.6.9-rc3 I began experiencing random
>> oom kills whenever a high memory i/o load took place.
> 
> 
> Do you have swap online?

When he first reported it he said no swap.

> What sort of machine is it, and how much memory has it?

Ditto - 1Gb ram.

Con

--------------enig28ED3D53887F7505506B965B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBeuMyZUg7+tp6mRURAiLFAJ93nfYIGCRkThjG4V2eCBxG1/nN4gCfZiqy
TR6KYjofMcA33itCuwy5XO0=
=JdZJ
-----END PGP SIGNATURE-----

--------------enig28ED3D53887F7505506B965B--
