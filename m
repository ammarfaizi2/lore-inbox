Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280757AbRKSWgf>; Mon, 19 Nov 2001 17:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280758AbRKSWgZ>; Mon, 19 Nov 2001 17:36:25 -0500
Received: from crateria.nerim.net ([62.4.16.75]:9222 "HELO crateria.nerim.net")
	by vger.kernel.org with SMTP id <S280757AbRKSWgQ>;
	Mon, 19 Nov 2001 17:36:16 -0500
Message-ID: <3BF98955.8060107@free.fr>
Date: Mon, 19 Nov 2001 23:36:05 +0100
From: Lionel Bouton <Lionel.Bouton@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011115
X-Accept-Language: en-us
MIME-Version: 1.0
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x bit for dirs: misfeature?
In-Reply-To: <Pine.GSO.4.21.0111190927100.17210-100000@weyl.math.psu.edu> <01111917034005.00817@nemo>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



vda wrote:

>On Monday 19 November 2001 14:46, Alexander Viro wrote:
>
>>On Mon, 19 Nov 2001, vda wrote:
>>
>>>[...]
>>>
>>See UNIX FAQ.  Ability to read != ability to lookup.
>>
>>Trivial example: you have a directory with a bunch of subdirectories.
>>You want owners of subdirectories to see them.  You don't want them
>>to _know_ about other subdirectories.
>>
>
>Security through obscurity, that is.
>

Security through obscurity is about hiding protection measures taken not 
about hiding sensible data...
Hiding sensible data is the main protection measures' purpose :-)

One single example :
Would you want to publish the exhaustive list of locations were your 
credit card number may be stored (even though it *should* be perfectly 
secure) or keep it hiden from public eyes ?

This is mainly OT on linux-kernel now. Feel free to mail me directly for 
future exchanges.

