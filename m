Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261895AbTCRBvf>; Mon, 17 Mar 2003 20:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261977AbTCRBvf>; Mon, 17 Mar 2003 20:51:35 -0500
Received: from ip-92-118-134-202.rev.dyxnet.com ([202.134.118.92]:31282 "EHLO
	mail.office") by vger.kernel.org with ESMTP id <S261895AbTCRBvd>;
	Mon, 17 Mar 2003 20:51:33 -0500
Message-ID: <3E767F44.9050006@thizgroup.com>
Date: Tue, 18 Mar 2003 10:07:00 +0800
From: =?Big5?B?QWxleCBMYXUgvEKrVL3l?= <alexlau@thizgroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030305
X-Accept-Language: zh-hk, zh-tw, zh-cn
MIME-Version: 1.0
To: Michiel Klaver <michiel@drecomm.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Tyan tiger 2466 mpx dual processor problem
References: <1047923169.3e7609e17dcab@slash.drecomm.nl>
In-Reply-To: <1047923169.3e7609e17dcab@slash.drecomm.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michiel Klaver wrote:

>My Tyan Tiger MPX 2466 mobo has two AMD Athlon MP 2400+ CPU's, but when running 
>a standard RedHat or Debian Kernel (i686-smp) it will only recognize one CPU.
>  
>
I'm using 2200+ same motherboard,
Debian Kernel-source-2.4.20, 19 and 18-SMP all recognized CPU

>When I build my own kernel (2.4.20) with athlon support (k7-smp) it will crash 
>at boot time.
>
Not to me... will that be 2400+ bug?

>My problem is that I can only log-in remotely, and a console monitor is not 
>(yet) available, so I have no clue about error messages... :(
>Lucky me to use the lilo -R option, so it will return to the default kernel 
>after an APC reboot.
>
>What could cause this behaviour?
>
>What should be the BIOS settings for MPS (1.1/1.4)? APIC (on/off)?
>
>  
>
I'm using 1.4 APIC on working find.
Hope that help.
Alex



