Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268483AbTANBe0>; Mon, 13 Jan 2003 20:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268485AbTANBeZ>; Mon, 13 Jan 2003 20:34:25 -0500
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:5656
	"EHLO mx1.corp.rackable.com") by vger.kernel.org with ESMTP
	id <S268483AbTANBeY>; Mon, 13 Jan 2003 20:34:24 -0500
Message-ID: <3E236B2C.1050403@rackable.com>
Date: Mon, 13 Jan 2003 17:43:08 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Edward Tandi <ed@efix.biz>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre3-ac3 and KT400
References: <1042489183.2617.28.camel@wires.home.biz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Jan 2003 01:43:11.0642 (UTC) FILETIME=[4C0B97A0:01C2BB6E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edward Tandi wrote:

>I'm new to this list and most of the e-mail here seems to be very
>low-level, so I'm not so sure if this is the right forum for these kinds
>of questions -please do point me in the right direction...
>
>I am running Linux on an ASUS A7V8X, VIA KT400 chipset motherboard. The
>processor is a 1.5GHz Athlon XP. I started experimenting with new-ish
>kernels again because of the general lack of kernel support for this
>chipset in stock kernels. 3 questions below:
>
>
>1) I have 1GB ram, but I cannot get high memory support to work. It
>falls over during boot. I've seen discussions about AMD cache issues,
>but has it been fixed yet? Is it supposed to work?
>
>  
>

  Have you tried to forcing the amount of memory?  Try something short 
of you expected total.  Maybe "mem=1000M".

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>



