Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317414AbSGTO1r>; Sat, 20 Jul 2002 10:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317410AbSGTO1r>; Sat, 20 Jul 2002 10:27:47 -0400
Received: from [210.78.134.243] ([210.78.134.243]:19981 "EHLO 210.78.134.243")
	by vger.kernel.org with ESMTP id <S317408AbSGTO1q>;
	Sat, 20 Jul 2002 10:27:46 -0400
Date: Sat, 20 Jul 2002 22:32:30 +0800
From: zhengchuanbo <zhengcb@netpower.com.cn>
To: "fxzhang@ict.ac.cn" <fxzhang@ict.ac.cn>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: problem with eepro100 NAPI driver
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-Id: <200207202235471.SM00792@zhengcb>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i tried ehe eepro100 NAPI driver on linux2.4.19. the kernel was compiled successfully. but when i tested the throughput of the system,i met some problem.
i tested the system with smartbits. when the frame size is 64bytes, in the beginning the system can receive and transmit packets. but after a while, the network card would not receive and transmit packets any more. 
then with frame size bigger than 128bytes, it worked well. the throughput was improved. (but sometimes it also has some problem just like 64bytes frames).
so what's the problem? is there something wrong with the driver?
please cc. thanks.


zhengchuanbo  

