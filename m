Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263219AbVGaMoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbVGaMoa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 08:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVGaMoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 08:44:30 -0400
Received: from 69.36.162.216.west-datacenter.net ([69.36.162.216]:37101 "EHLO
	schau.com") by vger.kernel.org with ESMTP id S261741AbVGaMoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 08:44:24 -0400
Message-ID: <42ECC7D3.4010806@schau.com>
Date: Sun, 31 Jul 2005 14:45:07 +0200
From: Brian Schau <brian@schau.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: chaosite@gmail.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.13-rc4] Bug in the wireless code?
References: <42EB94BC.3030604@schau.com> <200507301802.49019.vda@ilport.com.ua> <42EBBF17.5010503@schau.com> <42EC03B5.20805@gmail.com>
In-Reply-To: <42EC03B5.20805@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'd gladly supply you with any input - just tell what you need.

Actually, a dmesg in 2.6.11 and 2.6.12 looks very familiar.  Also the
NIC gets configured.   However the Link LED just blinks which means it
tries to establish a connection.
In 2.6.11 it stays solid after a couple of seconds.

/brian

Matan Peled wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Brian Schau wrote:
> 
>>Hi Denis/All,
>>
>>
>>I see the error in 2.6.12 as well (I just tried it).   My setup ...
>>
>>Zyxel ZyAir B-100 pcmcia wireless card.
>>D-Link AccessPoint.
>>
>>
>>/brian
>>
>>
>>Denis Vlasenko wrote:
>>
>>
>>>On Saturday 30 July 2005 17:54, Brian Schau wrote:
>>>
>>>
>>>>Hello,
>>>>
>>>>I am sorry to annoy you all.  I have problem in getting the
>>>>wireless orinoco driver to work in 2.6.13-rc4.   It works
>>>>like a charm in 2.6.11.
>>>>Doing a diff between the files for orinoco shows a lot of
>>>>differences.
>>>>
>>>>I'll gladly assist in any way I can.
>>>
>>>
>>>
>>>Does it work in 2.6.12? 2.6.13-rc1? rc2? rc3?
>>>
>>>(Please do not reply just to me, but to lkml)
> 
> 
> Whats the error?
> Any sort of output would probably be helpful.
> 
> - --
> [Name      ]   ::  [Matan I. Peled    ]
> [Location  ]   ::  [Israel            ]
> [Public Key]   ::  [0xD6F42CA5        ]
> [Keyserver ]   ::  [keyserver.kjsl.com]
> encrypted/signed  plain text  preferred
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.1 (GNU/Linux)
> 
> iD8DBQFC7AO0A7Qvptb0LKURAnDXAJ9zJmw4gK7LN1TkJFL+0JV4vPnhlgCeIGYn
> XHUFp4jfsja+qZWusru8MAA=
> =kEho
> -----END PGP SIGNATURE-----
> 
> 
