Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVDBT2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVDBT2H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 14:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVDBT2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 14:28:07 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:61785 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261201AbVDBT16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 14:27:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:x-enigmail-supports:content-type;
        b=dYGqdd2DPTImBg288vTRCVQjhIi0m6vE0G/B8+hoVe+0kpAh67dyF3rou+0//QnuKtmuMY+pXP4M/ZZVnh3Y5Did2qHGibcLm6rcD3PFvYlmglHmPTy6L89r0JzyDl0wFEH0LHIgaS6EbMrbErwhMlKnKDPJzkGKtybCEcnEFBE=
Message-ID: <424EF1D3.1070604@gmail.com>
Date: Sat, 02 Apr 2005 22:26:11 +0300
From: Matan Peled <chaosite@gmail.com>
Reply-To: chaosite@gmail.com
Organization: Chaosite Destruction, inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050326)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jacek Luczak <difrost@pin.if.uz.zgora.pl>
CC: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Something wrong with 2.6.12-rc1-RT-V0.7.43-05
References: <424EEF39.50805@pin.if.uz.zgora.pl>
In-Reply-To: <424EEF39.50805@pin.if.uz.zgora.pl>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB6F09DA79A92DC74050F7659"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB6F09DA79A92DC74050F7659
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Jacek Luczak wrote:
> 
> Hi
> 
> Early morning i made a 2.6.12-rc1 with RT-V0.7.43-05 and this is what I
> sow in dmesg after 6 hours of computers work:
> 
> <SNIP!>

Hmm... A lot of that seems to involve ndiswrapper. Is there any way you could
reproduce this without ndiswrapper loaded?
-- 
[Name      ]   ::  [Matan I. Peled    ]
[Location  ]   ::  [Israel            ]
[Public Key]   ::  [0xD6F42CA5        ]
[Keyserver ]   ::  [keyserver.kjsl.com]
encrypted/signed  plain text  preferred


--------------enigB6F09DA79A92DC74050F7659
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCTvHTA7Qvptb0LKURApukAJ0cNQ6eNlg6lrWmvRlvDCmERj9afwCfRzmW
p7sMyBok3+WOO/YBzeGRUO8=
=RfNr
-----END PGP SIGNATURE-----

--------------enigB6F09DA79A92DC74050F7659--
