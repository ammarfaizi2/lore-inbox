Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316477AbSGVGXQ>; Mon, 22 Jul 2002 02:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316491AbSGVGXQ>; Mon, 22 Jul 2002 02:23:16 -0400
Received: from [159.226.39.4] ([159.226.39.4]:30091 "HELO mail.ict.ac.cn")
	by vger.kernel.org with SMTP id <S316477AbSGVGXP>;
	Mon, 22 Jul 2002 02:23:15 -0400
Message-ID: <3D3BA72E.9070806@ict.ac.cn>
Date: Mon, 22 Jul 2002 14:33:18 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: zh-cn, en-us
MIME-Version: 1.0
To: zhengchuanbo <zhengcb@netpower.com.cn>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: problem with eepro100 NAPI driver
References: <200207202235471.SM00792@zhengcb>
Content-Type: text/plain; charset=x-gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I don't know which version you get.The ealier versions do have
serious problems. The latest one(6.19) on NAPI website works
well for me,but someone report problem of it too.Since i get no
environment and time to investigate it,the problem is pending now.
I will send you the latest patch in case you can't find it in other mail.

zhengchuanbo wrote:

>i tried ehe eepro100 NAPI driver on linux2.4.19. the kernel was compiled successfully. but when i tested the throughput of the system,i met some problem.
>i tested the system with smartbits. when the frame size is 64bytes, in the beginning the system can receive and transmit packets. but after a while, the network card would not receive and transmit packets any more. 
>then with frame size bigger than 128bytes, it worked well. the throughput was improved. (but sometimes it also has some problem just like 64bytes frames).
>so what's the problem? is there something wrong with the driver?
>please cc. thanks.
>
>
>zhengchuanbo  
>
>
>


