Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbULYLqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbULYLqz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 06:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbULYLqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 06:46:55 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:11867 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261503AbULYLqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 06:46:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:x-enigmail-supports:content-type;
        b=Dk7qirWEyL9uhYMXdOTLkDFdv8V4avh84FQoKltQ16E730jrG9T0md87ooJYjmtyTIP64IwbLZcrvbqZCATe77aDVlvkMpvda/0P+BNrlRuMUu/+lC8zbV9UAUmH2c3IU0mz34GqYnozYp5vXipN50fLBW50jR8e9Uu9CoaOw4Y=
Message-ID: <41CD5328.2090105@gmail.com>
Date: Sat, 25 Dec 2004 13:46:48 +0200
From: Matan Peled <chaosite@gmail.com>
Reply-To: chaosite@gmail.com
Organization: Chaosite Destruction, inc.
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rajsekar <raj--cutme--sekar@cse.iDELTHISitm.ernet.in>
CC: linux-kernel@vger.kernel.org
Subject: Re: Trying out SCHED_BATCH
References: <m3mzw262cu.fsf@rajsekar.pc>
In-Reply-To: <m3mzw262cu.fsf@rajsekar.pc>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1E4E9CEAC6920E0370C1B7A6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1E4E9CEAC6920E0370C1B7A6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Rajsekar wrote:
> I would like to try out the SCHED_BATCH.  Unfortunately, I am not able to
> find a patch for my kernel.  Could someone enlighten me on this?
> 
> I am running 2.6.10-rc1-mm2 with staircase scheduler patch.  My `uname -a'
> output is:
> 
> Linux rajsekar.pc 2.6.10-rc1-mm2staircase #2 Sat Dec 4 10:49:31 IST 2004 i686 AuthenticAMD unknown GNU/Linux
> 

2.6.10-ck1 can be found here (It has SCHED_BATCH):

http://members.optusnet.com.au/ckolivas/kernel/

-- 
[Name      ]   ::  [Matan I. Peled    ]
[Location  ]   ::  [Israel            ]
[Public Key]   ::  [0xD6F42CA5        ]
[Keyserver ]   ::  [keyserver.kjsl.com]
encrypted/signed  plaintext   preffered


--------------enig1E4E9CEAC6920E0370C1B7A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBzVMoA7Qvptb0LKURArjoAJ4vFmtxxqZG9Z1wdbD0vtAYFHgI2QCfUp1p
vHXoScfrEfeu140CD1NOI74=
=SVWA
-----END PGP SIGNATURE-----

--------------enig1E4E9CEAC6920E0370C1B7A6--
