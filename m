Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbVDVFKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbVDVFKW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 01:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVDVFHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 01:07:25 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:29730 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261975AbVDVFGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 01:06:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:x-enigmail-supports:content-type;
        b=WwYWDwgebYELP8+66J10LyS+SvF7fGkuD9ShWdWraguobZKOyEhUx8p84te412714LvSG4Ms7SVcMpKzGfkGeX5LU066cD4Yp63JnVbqo70fJB+vbqXR454D2QgmRJcK4hZ9ctmxp8CD6adb7XLsGCw0x0paeCk+CadJBEdG2pQ=
Message-ID: <42688649.2080600@gmail.com>
Date: Fri, 22 Apr 2005 08:06:17 +0300
From: Matan Peled <chaosite@gmail.com>
Reply-To: chaosite@gmail.com
Organization: Chaosite Destruction, inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050326)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcondes Monteiro de Arau <marcondes@linuxmail.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux Kernel
References: <20050422024346.3B8F223CFF@ws5-3.us4.outblaze.com>
In-Reply-To: <20050422024346.3B8F223CFF@ws5-3.us4.outblaze.com>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2C5D02AD936FA2FD87F7E218"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2C5D02AD936FA2FD87F7E218
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Marcondes Monteiro de Arau wrote:
> Hi!
> 
> I'm university student in Brazil and would like to know if during the process of compilation of the kernel of the linux the tecnology of cluster is used.
> 
> 
> 
> Marcondes
> 

Are you talking about using a cluster to compile the kernel? In that case,
Google for DistCC.

Are you asking if a compiled linux kernel can be used as part of a cluster?
openMosix is the project you're searching for.

-- 
[Name      ]   ::  [Matan I. Peled    ]
[Location  ]   ::  [Israel            ]
[Public Key]   ::  [0xD6F42CA5        ]
[Keyserver ]   ::  [keyserver.kjsl.com]
encrypted/signed  plain text  preferred


--------------enig2C5D02AD936FA2FD87F7E218
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCaIZMA7Qvptb0LKURAhQ+AKCUv274IhVU1IwNjTvtnR1q6L9wvgCgjFcr
fSBRaMU+N1cQ4r8c5FBbhG4=
=LWyS
-----END PGP SIGNATURE-----

--------------enig2C5D02AD936FA2FD87F7E218--
