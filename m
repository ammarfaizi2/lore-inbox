Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130633AbRAHUo0>; Mon, 8 Jan 2001 15:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131211AbRAHUoP>; Mon, 8 Jan 2001 15:44:15 -0500
Received: from hood.tvd.be ([195.162.196.21]:3056 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S129780AbRAHUoC>;
	Mon, 8 Jan 2001 15:44:02 -0500
Message-Id: <4.3.2.7.2.20010108214115.00bd04d0@mail.chello.be>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 08 Jan 2001 21:43:28 +0100
To: "Timothy A. DeWees" <whtdrgn@mail.cannet.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
From: Ward Vandewege <ward.vandewege@chello.be>
Subject: Re: real talk cards in 2.2.18.
In-Reply-To: <001201c079b0$a968da40$7930000a@hcd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 15:22 08/01/2001 -0500, Timothy A. DeWees wrote:
>Hello,
>
>     I am trying to compile the rtl8139 driver for my SMC
>10/100 NIC.  I have turned on all 10/100 devices (i.e. 3Com
>cards -n- such); however, I can not get the rtl driver to show
>up as an option in my menuconfig.  What to I need to do to
>compile this driver as a module.  Am I missing something
>else perhaps not in Network Devices.  I do see the rtl8139.c file in my 
>drivers/net source tree.

Just enable 'Prompt for development and/or incomplete code/drivers' in 
'Code maturity level options', the first item in the setup menu...

Bye for now,
Ward.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
