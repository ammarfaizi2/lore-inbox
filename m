Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274720AbRJFOVm>; Sat, 6 Oct 2001 10:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275041AbRJFOVd>; Sat, 6 Oct 2001 10:21:33 -0400
Received: from femail23.sdc1.sfba.home.com ([24.0.95.148]:64494 "EHLO
	femail23.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S275173AbRJFOVZ>; Sat, 6 Oct 2001 10:21:25 -0400
Message-ID: <3BBF1359.2020305@home.com>
Date: Sat, 06 Oct 2001 10:21:13 -0400
From: Willem Riede <wriede@home.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010809
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jussi Laako <jussi.laako@kolumbus.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux and 760MP
In-Reply-To: <E15pdJC-0007ow-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>Alan Cox wrote:
>>
>>>memory the production ones have a couple of IDE errata (performance and
>>>can't enable prefetching) and an APIC one
>>>
>>Is there workaround for these in recent -ac kernels? So is it safe to buy
>>Tyan Tiger MP for example?
>>
>
>Nothing should be needed. If it is then running "noapic" is going to cure
>it.
>-
>
I've got my Tyan Tiger MP up now for about a week, running a 2.4.9-ac18 
kernel with
some of the patches from Red Hat's Rawhide kernel rpm applied, and I've 
not needed
"noapic" and it's been perfectly stable. I'm not through testing or 
optimizing performance
though, but so far so good.

Willem Riede.


