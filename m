Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269847AbUH0AxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269847AbUH0AxZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 20:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269761AbUH0Atx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 20:49:53 -0400
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:23197 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S269794AbUH0ArN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 20:47:13 -0400
Message-ID: <412E8475.5000505@kolivas.org>
Date: Fri, 27 Aug 2004 10:46:45 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Rick Lindsley <ricklind@us.ibm.com>
Subject: Re: 2.6.9-rc1-mm1
References: <20040826014745.225d7a2c.akpm@osdl.org> <412DC47B.4000704@kolivas.org> <200408261636.06857.rjw@sisk.pl> <412E11ED.7040300@kolivas.org> <52540000.1093553736@flay> <412E7004.3070503@kolivas.org> <412E824F.90704@vgertech.com>
In-Reply-To: <412E824F.90704@vgertech.com>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1877F57F6C26B22A116DB26C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1877F57F6C26B22A116DB26C
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nuno Silva wrote:
> Con Kolivas wrote:
>> If you're talking about using the embedded image viewer in kde, that 
>> spins on wait and wastes truckloads of cpu (a perfect example of poor 
>> coding). Try loading it an external viewer and it will be 1000 times 
>> faster. If you're talking about it keeping the disk too busy on the 
>> other hand, that's I/O scheduling.
>>
> 
> The question is: "can a poorly coded app hang the system for 30secs?"
> 
> That's a DoS ;-)

It does not hang the system, only it's dependant tasks (ie other kde 
thingies)

Con

--------------enig1877F57F6C26B22A116DB26C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBLoR3ZUg7+tp6mRURAjXUAJ0SUf6e5rt/kBfqe5L80jLmprFJ+QCfaYuG
szd9rkFv7yFcNjXPHc4CKiY=
=nBis
-----END PGP SIGNATURE-----

--------------enig1877F57F6C26B22A116DB26C--
