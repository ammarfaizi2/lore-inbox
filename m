Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262201AbVAQQpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbVAQQpo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 11:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbVAQQpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 11:45:44 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:11838 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262201AbVAQQph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 11:45:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:x-enigmail-supports:content-type;
        b=oaSKA8UtXIP3ISXG5Q7s6oXu7trZwChuwVR1OYh4HArXgtMHH94+HwT8egBfL4nQVAsTPpDxi1kOwmhDVyYiGqNgrH2Ym5/EtUNoaygDqgPyPaLm2GVG4OucCxgSYJYyxJ0sCzr+s2MaT5889JUfL3lehH8lxFX9NEuJkJGpCG0=
Message-ID: <41EBE974.8050309@gmail.com>
Date: Mon, 17 Jan 2005 18:36:04 +0200
From: Matan Peled <chaosite@gmail.com>
Reply-To: chaosite@gmail.com
Organization: Chaosite Destruction, inc.
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Watts <m.watts@eris.qinetiq.com>
CC: linux-kernel@vger.kernel.org, Klaus Dittrich <kladit@t-online.de>
Subject: Re: brought up 4 cpu's
References: <20050117153646.GA25273@xeon2.local.here> <200501171609.15054.m.watts@eris.qinetiq.com> <41EBE54B.1010401@xeon2.local.here> <200501171632.26443.m.watts@eris.qinetiq.com>
In-Reply-To: <200501171632.26443.m.watts@eris.qinetiq.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4E083C3B4305CDCB06CC0899"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4E083C3B4305CDCB06CC0899
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> kernel-2.6.11-rc1-bk5 stops booting after the message
                         ^^^^^
> "Brought up 4 CPU'S"

Something makes me think that this message is not about the fact that the linux 
kernel found 4 logical CPUs, but that it stopped after the message was shown :)

A .config would be nice, maybe a bit more information about your system?

-- 
[Name      ]   ::  [Matan I. Peled    ]
[Location  ]   ::  [Israel            ]
[Public Key]   ::  [0xD6F42CA5        ]
[Keyserver ]   ::  [keyserver.kjsl.com]
encrypted/signed  plain text  preferred


--------------enig4E083C3B4305CDCB06CC0899
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFB6+l0A7Qvptb0LKURApgpAJwPCnZ/i+rRClilZGKQ0kmRgKae7ACeOKvZ
2iSFEsBORxzjygi2b8VFDsQ=
=27lI
-----END PGP SIGNATURE-----

--------------enig4E083C3B4305CDCB06CC0899--
