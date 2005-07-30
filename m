Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263165AbVG3Ws1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263165AbVG3Ws1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 18:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263177AbVG3Ws1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 18:48:27 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:52333 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263165AbVG3WsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 18:48:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=r+cuFkZ4tstxC+i6DGiczHjNIXM5/WD90jo8L6m3EFZe8Wj4MT1T4uSntyG4lGus0INXY5Sc/dXsph4laM1ifYh5XtHj0igy1lhHfz/hHjryFoGmurlLUA3WLoYPlFIWdyc0it3Xpy3MwYItL5CuQqXR/G1roncs7NGrHcU/gec=
Message-ID: <42EC03B5.20805@gmail.com>
Date: Sun, 31 Jul 2005 01:48:21 +0300
From: Matan Peled <chaosite@gmail.com>
Reply-To: chaosite@gmail.com
Organization: Chaosite Destruction, inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050722 Thunderbird/1.0.6 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brian Schau <brian@schau.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.13-rc4] Bug in the wireless code?
References: <42EB94BC.3030604@schau.com> <200507301802.49019.vda@ilport.com.ua> <42EBBF17.5010503@schau.com>
In-Reply-To: <42EBBF17.5010503@schau.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Brian Schau wrote:
> Hi Denis/All,
> 
> 
> I see the error in 2.6.12 as well (I just tried it).   My setup ...
> 
> Zyxel ZyAir B-100 pcmcia wireless card.
> D-Link AccessPoint.
> 
> 
> /brian
> 
> 
> Denis Vlasenko wrote:
> 
>> On Saturday 30 July 2005 17:54, Brian Schau wrote:
>>
>>> Hello,
>>>
>>> I am sorry to annoy you all.  I have problem in getting the
>>> wireless orinoco driver to work in 2.6.13-rc4.   It works
>>> like a charm in 2.6.11.
>>> Doing a diff between the files for orinoco shows a lot of
>>> differences.
>>>
>>> I'll gladly assist in any way I can.
>>
>>
>>
>> Does it work in 2.6.12? 2.6.13-rc1? rc2? rc3?
>>
>> (Please do not reply just to me, but to lkml)

Whats the error?
Any sort of output would probably be helpful.

- --
[Name      ]   ::  [Matan I. Peled    ]
[Location  ]   ::  [Israel            ]
[Public Key]   ::  [0xD6F42CA5        ]
[Keyserver ]   ::  [keyserver.kjsl.com]
encrypted/signed  plain text  preferred

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC7AO0A7Qvptb0LKURAnDXAJ9zJmw4gK7LN1TkJFL+0JV4vPnhlgCeIGYn
XHUFp4jfsja+qZWusru8MAA=
=kEho
-----END PGP SIGNATURE-----
