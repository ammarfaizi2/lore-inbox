Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315485AbSFKCLH>; Mon, 10 Jun 2002 22:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316652AbSFKCLG>; Mon, 10 Jun 2002 22:11:06 -0400
Received: from [61.132.182.1] ([61.132.182.1]:24672 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id <S315485AbSFKCLF>;
	Mon, 10 Jun 2002 22:11:05 -0400
Date: Tue, 11 Jun 2002 10:09:15 +0800 (CST)
From: Wang Hui <whui@mail.ustc.edu.cn>
X-X-Sender: <whui@mail>
To: <linux-kernel@vger.kernel.org>
Subject: What dose 'general protection fault: 0000' mean?
Message-ID: <Pine.GSO.4.31L2A.0206111003200.10818-100000@mail>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all,

I am coding a linux kernel module, but when I run my testing code I got
a kernel panic.  And the panic screen said:

general protection fault:0000
CPU: 0
EIP: 0010:[<d289a213>]       Tainted: P
EFLAGS: 00010297
............
............
Code: 8b 02 8b 55 08 89 02 8b 55 0c 8b 42 04 8b 55 08 89 42 04 8b
<0> Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

==================================================

I am a newbie to linux kernel hacking.  I dont know how to find out
where is the fault code.  :(  Could anyone give me some hints???

Thanks a lot in advance!!

Regards,
Wang Hui.

