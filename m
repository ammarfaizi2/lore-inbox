Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313911AbSEHNER>; Wed, 8 May 2002 09:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313924AbSEHNEQ>; Wed, 8 May 2002 09:04:16 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:4289 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S313911AbSEHNEP>; Wed, 8 May 2002 09:04:15 -0400
Message-ID: <3CD921F2.5070605@antefacto.com>
Date: Wed, 08 May 2002 14:02:42 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tomasz Rola <rtomek@cis.com.pl>
CC: mikeH <mikeH@notnowlewis.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: lost interrupt
In-Reply-To: <Pine.LNX.3.96.1020508042330.2702K-100000@pioneer>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Rola wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Tue, 7 May 2002, mikeH wrote:
> 
> 
>>Sorry if this is a repeat, I didn't see my last post come through...
>>
>>I'm being plauged with "hdX: lost interrupt" messages and resultant 
>>system hangs in kernel 2.4.18 on a via 82XXXX chipset.
> 
> 
> I may not be the right person to answer but I had same problem (same via,
> same kernel, same interrupt). It helped when I turned unmasking off, i.e.
> try:
> 
> hdparm -u0 /dev/hdX  for every X in existing disks you have problems with.
> 

unmasking is already off on my drive

Padraig.

