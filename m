Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270317AbSISIBe>; Thu, 19 Sep 2002 04:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270348AbSISIBe>; Thu, 19 Sep 2002 04:01:34 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:29880 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S270317AbSISIBc>;
	Thu, 19 Sep 2002 04:01:32 -0400
Message-Id: <200209190806.g8J86NPl056072@northrelay04.pok.ibm.com>
User-Agent: Pan/0.11.2 (Unix)
From: "Vamsi Krishna S." <vamsi_krishna@in.ibm.com>
To: "Yumiko Sugita" <sugita@sdl.hitachi.co.jp>, vamsi@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: Release of LKST 1.3
Date: Thu, 19 Sep 2002 13:48:53 +0530
References: <5.0.2.6.2.20020918210036.05287a40@sdl99c>
Reply-To: vamsi_krishna@in.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>From the howto-1.3.txt

> Known Problems:
>
> - GCC 2.96, which is a kernel compiler in RedHat, with -O2 option generates
> wrong code around Kernel Hooks that caused the kernel panic. To avoid this
> problem, you use the GCC 2.95, which is a standard kernel compiler.

I use 2.96 here all the time and haven't seen it miscompile hooks. Can you 
please elaborate what the problems are and give a me small sample code
to demonstrate the problem.

Thanks,
Vamsi.

--
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com
