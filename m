Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317977AbSIJSqx>; Tue, 10 Sep 2002 14:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318009AbSIJSqw>; Tue, 10 Sep 2002 14:46:52 -0400
Received: from christpuncher.kingsmeadefarm.com ([209.216.78.83]:45227 "HELO
	the-grudge.myip.org") by vger.kernel.org with SMTP
	id <S317977AbSIJSqw>; Tue, 10 Sep 2002 14:46:52 -0400
Message-ID: <1031683898.3d7e3f3a83c2a@webmail>
Date: Tue, 10 Sep 2002 14:51:38 -0400
From: Joe Kellner <jdk@kingsmeadefarm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20pre5aa2
References: <20020909165007.GA17868@dualathlon.random>
In-Reply-To: <20020909165007.GA17868@dualathlon.random>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 192.168.1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrea Arcangeli <andrea@suse.de>:

> 2.4.20pre5aa1 had a deadlock in the sched_yield changes (missing _irq
> while taking the spinlock). this new one should be rock solid ;).
> 
> URL:
> 
> 
http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20pre5aa2.gz
> 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20pre5aa2/
> 


Andrea, 
I've tried using this kernel on a dual atlon MP system using a Tyan thunder K7
board and two athlon MP 1900's. When it goes to load the kernel image the system
just reboots. I'm using the exact same .config as I used with 2.4.20pre5aa1,
which worked fine. If you need any more information I'll be glad to provide it.

-------------------------------------------------
sent via KingsMeade secure webmail http://www.kingsmeadefarm.com
