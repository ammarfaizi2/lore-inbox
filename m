Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273596AbRIVEii>; Sat, 22 Sep 2001 00:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273609AbRIVEi2>; Sat, 22 Sep 2001 00:38:28 -0400
Received: from cm038.32.234.24.lvcm.com ([24.234.32.38]:11398 "EHLO osafo.com")
	by vger.kernel.org with ESMTP id <S273596AbRIVEiW>;
	Sat, 22 Sep 2001 00:38:22 -0400
Message-ID: <3BAC153A.4060700@osafo.com>
Date: Fri, 21 Sep 2001 21:36:10 -0700
From: Colin Frank <kernel@osafo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Abe Hayhurst <abe@avidsublimation.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Best gigabit card for linux
In-Reply-To: <001a01c13fed$ef3806f0$6c01a8c0@ABEPC>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In the following test. I was able to achieve close to 40 MegaBytes
per second using the packet engines Hamachi driver.

http://www.linuxcare.com/labs/sol-val/3w-esc6800-web.epl
Test done with:
    Packet engines Hamachi card
    3ware escalade 6800
    2.2.16 kernel.
    Cisco 6500
    10 - 20 client machines each with eepro100 cards

Colin...

Abe Hayhurst wrote:

>Hi Alan,
>
>I wanted to know your opinion as to which combination of gigabit cards (both
>fiber and copper) and drivers would yield the best performance (mostly
>transferring large files from server to client, but also latency) in Linux.
>I am not a programmer, a kernel tweaker, or a driver developer. I need a
>card that either has a driver that comes with Red Hat Linux 7.1 or is easy
>to install and needs minimal tweaks to the driver. I am currently
>considering cards from 3Com (Alteon), Broadcom, Intel, and SysKonnect.
>
>Thanks for your help,
>
>Abe Hayhurst
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>


