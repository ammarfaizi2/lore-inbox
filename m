Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbVCOT7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVCOT7W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 14:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVCOTzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 14:55:37 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:33820 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261828AbVCOTv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 14:51:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:x-enigmail-supports:content-type;
        b=MRiqBebZfDFMkAPjAs+wcGW2r5MWZd/jxT/zl+p0JXvEzBMztpyUET3ZZ0fbvXdSIqnWFvCEqQIq6AmbEx11uFxs3OieBUaLZNStmTUPKgbRZVuUs6PInn+wzEoQhn+y9y7jjxchp1YRuw5gvpxAwYDoWmKQ5iSAxmlDcaL2PCI=
Message-ID: <42373CAC.6080500@gmail.com>
Date: Tue, 15 Mar 2005 21:51:08 +0200
From: Matan Peled <chaosite@gmail.com>
Reply-To: chaosite@gmail.com
Organization: Chaosite Destruction, inc.
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Chris Friesen <cfriesen@nortel.com>,
       "Justin M. Forbes" <jmforbes@linuxtx.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.Stable and EXTRAVERSION
References: <Pine.LNX.3.96.1050311154019.20262B-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1050311154019.20262B-100000@gatekeeper.tmr.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDF952C933CE168F630B3FB32"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDF952C933CE168F630B3FB32
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Bill Davidsen wrote:
> I have to see what that generates. The problem is LOCALVERSION and current
> use of both 3 and 4 field kernel versions. You need a smarter script to
> handle that.
> 

... To which the knee jerk solution would be ...

Name Linus's kernel releases 2.6.z.0 ... ?


-- 
[Name      ]   ::  [Matan I. Peled    ]
[Location  ]   ::  [Israel            ]
[Public Key]   ::  [0xD6F42CA5        ]
[Keyserver ]   ::  [keyserver.kjsl.com]
encrypted/signed  plain text  preferred


--------------enigDF952C933CE168F630B3FB32
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCNzywA7Qvptb0LKURAnTOAJ0fI//vr12LXeBCe/TN368cV8/HKwCfdeK6
mm3glkS2zZIwCb6Tti9c3HY=
=fKSK
-----END PGP SIGNATURE-----

--------------enigDF952C933CE168F630B3FB32--
