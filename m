Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbUKWTZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbUKWTZK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 14:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbUKWTXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 14:23:14 -0500
Received: from pop.gmx.net ([213.165.64.20]:31398 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261505AbUKWTV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 14:21:59 -0500
X-Authenticated: #4512188
Message-ID: <41A38DF8.40907@gmx.de>
Date: Tue, 23 Nov 2004 20:22:32 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041114)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: William Lee Irwin III <wli@holomorphy.com>, Jan De Luyck <lkml@kcore.org>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [2.6.10-rc2] XFS filesystem corruption
References: <200411221530.30325.lkml@kcore.org>	 <20041122155106.GG2714@holomorphy.com>  <41A30D3E.9090506@gmx.de> <1101237223.6358.10.camel@krustophenia.net>
In-Reply-To: <1101237223.6358.10.camel@krustophenia.net>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDD8C33BBD5079D789DF4012A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDD8C33BBD5079D789DF4012A
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Lee Revell schrieb:
> On Tue, 2004-11-23 at 11:13 +0100, Prakash K. Cheemplavam wrote:
> 
>>Is xfs known to be broken while preempt is on? (Esp 
>>using ck's preemp big kernel lock?)
> 
> 
> Minor nitpick:  Ingo wrote the preempt BKL code, not Con.

Oh yes, I know, but it is in Con's kernel, and IIRC he merged nto all of 
his patches, so I thought this would be more precise. ;-)

Prakash

--------------enigDD8C33BBD5079D789DF4012A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBo434xU2n/+9+t5gRAua8AJ4u9qPkE47iOiWY7KYxjv7EvUVqFACgx5Yk
ee1pA0+PNT1cdb0Hl38d1gw=
=ygcz
-----END PGP SIGNATURE-----

--------------enigDD8C33BBD5079D789DF4012A--
