Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317729AbSGPBSh>; Mon, 15 Jul 2002 21:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317728AbSGPBSg>; Mon, 15 Jul 2002 21:18:36 -0400
Received: from [210.78.134.243] ([210.78.134.243]:42513 "EHLO 210.78.134.243")
	by vger.kernel.org with ESMTP id <S317726AbSGPBSg>;
	Mon, 15 Jul 2002 21:18:36 -0400
Date: Tue, 16 Jul 2002 9:23:45 +0800
From: zhengchuanbo <zhengcb@netpower.com.cn>
To: Mark Hahn <hahn@physics.mcmaster.ca>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: how to improve the throughput of linux network
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-Id: <200207160926819.SM00792@zhengcb>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> we use linux as our router. i just tested the performance of the router with smartbits, and i found that the throughput of 64byte frame is only 25%, about 35kpps. 
>> someone mentioned that the throughput of 64byte frame could reach 70kpps.so i wish i could improve the performance of our router,but i don't know how to do that.

>you will probably need to provide a lot more details,
>such as what the host CPU is, whether you've done any
>kernel profiling, which kernel you're using, etc.

the CPU is PIII800, 256M ram. 
kernel 2.4.19-pre1
i just add some patches of netfilter to the kernel,such as the time patch. btw,i compiled all the netfilter options into the kernel,not as modules. will that affect the performance?
thanks.

chuanbo zheng


