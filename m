Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270526AbRHHQvQ>; Wed, 8 Aug 2001 12:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270524AbRHHQvG>; Wed, 8 Aug 2001 12:51:06 -0400
Received: from www.grips.com ([62.144.214.31]:54790 "EHLO grips_nts2.grips.com")
	by vger.kernel.org with ESMTP id <S270523AbRHHQuy>;
	Wed, 8 Aug 2001 12:50:54 -0400
Message-ID: <3B716E0A.8030005@grips.com>
Date: Wed, 08 Aug 2001 18:51:22 +0200
From: jury gerold <geroldj@grips.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010701
X-Accept-Language: de-at, en
MIME-Version: 1.0
To: Thodoris Pitikaris <thodoris@cs.teiher.gr>
CC: linux-kernel@vger.kernel.org
Subject: Re: is this a bug?
In-Reply-To: <3B6FD644.7020409@cs.teiher.gr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the same motherboard, same chipset, same CPU and the same crash.
No memory test cpu burn UDMA on/off, replace or remove of components
did any good.
Then i replaced the 100mhz SDRAM with a 133mhz and it is 100 % stable 
since then.
No matter which compiler, kernel version, cputype.
It simply works now.

Gerold

Thodoris Pitikaris wrote:

> As you will see in the attached file (it's a dmesg from the boot)
> I have an 1Ghz athlon cpu with a VIA KT133 on a gigabyte GA-7ZX 
> motherboard with 100mhz SDRAM.When I compiled the kernel with 
> cputype=Athlon I continiusly experienced this crash.When I compiled 
> with cputype=i686 everything went smooth (OS is Redhat 7.1)        Yours
>
> Theodore Pitikaris



