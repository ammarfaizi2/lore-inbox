Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264797AbRHMTnQ>; Mon, 13 Aug 2001 15:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266381AbRHMTnG>; Mon, 13 Aug 2001 15:43:06 -0400
Received: from [207.171.197.68] ([207.171.197.68]:7298 "EHLO bbs.bsdprime.org")
	by vger.kernel.org with ESMTP id <S264797AbRHMTmz>;
	Mon, 13 Aug 2001 15:42:55 -0400
Message-ID: <3B782D38.3080600@cheek.com>
Date: Mon, 13 Aug 2001 12:40:40 -0700
From: Joseph Cheek <joseph@cheek.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010712
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Peter J. Braam" <braam@clusterfilesystem.com>,
        Johannes Erdfelt <johannes@erdfelt.com>, linux-kernel@vger.kernel.org,
        linux-usb-users@lists.sourceforge.net
Subject: Re: 2.4.8-ac2 USB keyboard capslock hang
In-Reply-To: <E15WM1P-0007uJ-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this bug has been around since 2.4.3-ac *at least*, and the linux-usb 
folks are aware of it [but can't get a repro].  i've had repros since 
2.4.3-ac.

this is the first time afaik that this bug has been reported on a non 
ms-natural-pro keyboard tho.

Alan Cox wrote:

>>On Mon, Aug 13, 2001 at 06:56:48PM +0100, Alan Cox wrote:
>>
>>>Roswell is the Red Hat 7.2 beta, so its probably another bug that was fixed
>>>in the USB and input updates in -ac
>>>
>>It hangs on 2.4.8-ac2, so was this bug fix lost perhaps? 
>>
>
>It would be useful to know if 2.4.7ac3 say works and if so which one after
>that it broke at
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
thanks!

joe

--
Joseph Cheek, CTO, Redmond Linux Corp.
joseph@redmondlinux.org, www.redmondlinux.org
Redmond Linux.  Linux is for everyone.



