Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbVCHFAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVCHFAY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 00:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbVCHFAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 00:00:24 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:52788 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261759AbVCHFAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 00:00:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:x-enigmail-supports:content-type;
        b=kCNc/DEaoSR1ZY7rYvNi5IQEHWzKGTG7Shw/xMn1UfW34JRoxtuqtJGoAToW1ozrRkTBeH8GMNHqP2kcLmBuv7Ih0qW61u/OCdaiFsBydPKC14AWnpQwdZhr8PleSWyzxvT5qAiqVuV3ra6EU10vmq9zvNxGp/4nBisRwWEStHU=
Message-ID: <422D3155.9000102@gmail.com>
Date: Tue, 08 Mar 2005 07:00:05 +0200
From: Matan Peled <chaosite@gmail.com>
Reply-To: chaosite@gmail.com
Organization: Chaosite Destruction, inc.
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Michal Januszewski <spock@gentoo.org>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [announce 7/7] fbsplash - documentation
References: <20050308021706.GH26249@spock.one.pl> <200503080418.08804.arnd@arndb.de>
In-Reply-To: <200503080418.08804.arnd@arndb.de>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC9528BC61321363D8C2E62D3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC9528BC61321363D8C2E62D3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Arnd Bergmann wrote:
> Nothing about the init command seems really necessary. Why not just do 
> that stuff from an /sbin/init script?

I'm not a kernel hacker by any definition, but I'm pretty sure its neccasery 
because we want it to be done before /sbin/init is ran, AKA hide the kernel 
messages :)

-- 
[Name      ]   ::  [Matan I. Peled    ]
[Location  ]   ::  [Israel            ]
[Public Key]   ::  [0xD6F42CA5        ]
[Keyserver ]   ::  [keyserver.kjsl.com]
encrypted/signed  plain text  preferred


--------------enigC9528BC61321363D8C2E62D3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCLTFYA7Qvptb0LKURAvnBAKCJsNIa7q3QO//CA0RKGMklV74kjACfXiHM
xZ8Cjkb3XTt+dB/7jQbSCv8=
=07kU
-----END PGP SIGNATURE-----

--------------enigC9528BC61321363D8C2E62D3--
