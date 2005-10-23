Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbVJWKKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbVJWKKT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 06:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbVJWKKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 06:10:18 -0400
Received: from xproxy.gmail.com ([66.249.82.197]:14255 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751443AbVJWKKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 06:10:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        b=t7wiYwpSAIiFOiXC774ctcA2Sk8TH0o2th0ixH5bQiGorxROfE/b5/CIyiOS3sGn05kuPkVaVLNyFOFJW5fXdlR8lRrJCvEmmkL+VQXHfvWyGVW/TtTVobL5kaHzAgYLyPwB+TeJIKncR3MTlCc+YxAK1LqHTo6jZ038EpVyovY=
Message-ID: <435B61D4.9090009@gmail.com>
Date: Sun, 23 Oct 2005 12:11:32 +0200
From: Matan Peled <chaosite@gmail.com>
Reply-To: chaosite@gmail.com
Organization: Chaosite Destruction, inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20051014 Thunderbird/1.0.7 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gaurav Dhiman <gaurav4lkg@gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Problem]: accessing Marvell LAN card (sk98lin.ko)
References: <1e33f5710510230202q2623ff61w275e2aabac72b0a6@mail.gmail.com>
In-Reply-To: <1e33f5710510230202q2623ff61w275e2aabac72b0a6@mail.gmail.com>
X-Enigmail-Version: 0.92.0.0
OpenPGP: id=D6F42CA5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Gaurav Dhiman wrote:
> I have Toshiba M55 325 Laptop, which have Marvell 10/100 Base-TX
> Ethernet card. I think the driver for this is sk98lin.ko, I am also
> successful in loading that (saw lsmod). After loading when I do 'ls
> /proc/net/sk98lin/' , it does not show me anything.
> 
> I am not able to understand how can I access the network card, what
> device file I need to use for that ? When I do ifconfig, it only shows
> me the loopback interface.
> 
> Looking for any healp on this.

What about ifconfig -a?

> regards,
> - Gaurav

- - mip

- --
[Name      ]   ::  [Matan I. Peled    ]
[Location  ]   ::  [Israel            ]
[Public Key]   ::  [0xD6F42CA5        ]
[Keyserver ]   ::  [keyserver.kjsl.com]
encrypted/signed  plain text  preferred

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDW2HTA7Qvptb0LKURAvxKAJ9/TFFJx8qEMQ4VaFX0Cd4+XpU8EQCgmbGH
0NVsCHL8WJT64UXnmu6V5AA=
=iITg
-----END PGP SIGNATURE-----
