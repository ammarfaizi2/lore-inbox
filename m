Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbTIHPJn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 11:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbTIHPJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 11:09:43 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:43927 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S262420AbTIHPJl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 11:09:41 -0400
Message-ID: <3F5C9BDA.9080705@softhome.net>
Date: Mon, 08 Sep 2003 17:10:18 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [OT] Re: nasm over gas?
References: <tt0q.6Rc.17@gated-at.bofh.it> <tt0r.6Rc.19@gated-at.bofh.it> <tt0r.6Rc.21@gated-at.bofh.it> <tt0r.6Rc.23@gated-at.bofh.it> <tt0r.6Rc.25@gated-at.bofh.it> <tt0q.6Rc.15@gated-at.bofh.it> <tuIT.TW.7@gated-at.bofh.it>
In-Reply-To: <tuIT.TW.7@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> 
> I strongly suggest that if you have an interest in assembly, you
> cultivate that interest. Soon most all mundane coding will be
> performed by machine from a specification written by "Sales".
> The only "real" programming will be done by those who can make
> the interface between the hardware and the "coding machine". That's
> assembly!
> 

   I have a long standing dispute with one of my friend: once he has 
said 'asm is dead - every one is using C/C++ now'.

   Those I wasn't able to counter this claim. TSR programmes gone 
together with DOS, and ordinary desktops started challenging expensive 
workstations.

   But little bit later I caught an example: Palm OS. Yes. A lot of 
stuff is written in Asm. Why? Because *size does matter*: size == price, 
bigger application - more expensive it is for your customer. C was not 
able to compete with Asm.

   But now we have hand-helds/mobiles which do run Windoz/Linux. Run 
them almost unmodified/unstripped. Cool. C/C++ rules. Windoz CE with VBA 
- dream of idiot.

   Asm dead again? No-o-o-o. L3/L4 switch we are doing utilizes special 
micro-controller, which can be programmed in dialect of MIPS assembler. 
It has fast RAM for 4K of insn's and executes in real-time. I didn't saw 
C compiler for this - but this is really exotic example. But still 
example - Asm is far from being dead.

   What will be next? In my short carrier I saw as Asm was dying three 
times. But I beleive it will reborn over and over again ;-)))

