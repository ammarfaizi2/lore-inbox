Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263713AbUGLVc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbUGLVc1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 17:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbUGLVc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 17:32:27 -0400
Received: from mail013.syd.optusnet.com.au ([211.29.132.67]:38277 "EHLO
	mail013.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263713AbUGLVcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 17:32:25 -0400
Message-ID: <40F30364.5020405@kolivas.org>
Date: Tue, 13 Jul 2004 07:32:20 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Lenar_L=F5hmus?= <lenar@vision.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc1 -ck snapshot
References: <40F2A9C9.2040107@kolivas.org> <40F2B4C6.5010307@vision.ee>
In-Reply-To: <40F2B4C6.5010307@vision.ee>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigACC8315636F9C6C0FDCCC6FE"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigACC8315636F9C6C0FDCCC6FE
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Lenar Lõhmus wrote:
> Hi,
> 
> Con Kolivas wrote:
> 
>> I've posted a snapshot of the current -ck development against 2.6.8-rc1
> 
> 
> Just compiled it, found one minor problem (2.6.8-rc1-ck5+reiserfs4)
> which was fixed like this (maybe reiserfs4 patch is the offender):

Thanks. The reiser4 snapshot was not part of the full snapshot for 
safety reasons so I never quite got to fixing it. I'll update the 
reiser4 snapshot in that directory soon.

Cheers,
Con

--------------enigACC8315636F9C6C0FDCCC6FE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA8wNkZUg7+tp6mRURAkINAKCJ1x7r8PT1S/pyyDzznLeb5to6EwCfc4YP
cCPNRKIdSHhpd57kCByjuFI=
=NqpW
-----END PGP SIGNATURE-----

--------------enigACC8315636F9C6C0FDCCC6FE--
