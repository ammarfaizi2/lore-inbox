Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313589AbSERSQp>; Sat, 18 May 2002 14:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313660AbSERSQo>; Sat, 18 May 2002 14:16:44 -0400
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:458 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S313589AbSERSQn>; Sat, 18 May 2002 14:16:43 -0400
Message-ID: <3CE697B1.7040904@notnowlewis.co.uk>
Date: Sat, 18 May 2002 19:04:33 +0100
From: mikeH <mikeH@notnowlewis.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020502
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cantab.net>
CC: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: linux 2.5.16 and VIA Chipset
In-Reply-To: <Pine.NEB.4.44.0205181706400.21287-100000@mimas.fachschaften.tu-muenchen.de> <5.1.0.14.2.20020518191232.04027ec0@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:

>>
>>
>> I havent done anything like copying the old .config from my 2.4 
>> series kernel, this was a clean
>> tar jxvf linux-2.5.16.tar.bz2 && cd linux-2.5.16 && make menuconfig
>
>
> hm. try a make mrproper
>
> and then a make menuconfig
>
> Anton
>
>
>

Tried that, still nothing. I'll try downloading the patch and patching 
it against 2.4.18.

mike

