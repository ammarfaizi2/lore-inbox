Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315414AbSGHJKg>; Mon, 8 Jul 2002 05:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316499AbSGHJKf>; Mon, 8 Jul 2002 05:10:35 -0400
Received: from smtp.cs.curtin.edu.au ([134.7.1.4]:19721 "EHLO
	smtp.cs.curtin.edu.au") by vger.kernel.org with ESMTP
	id <S315414AbSGHJKe>; Mon, 8 Jul 2002 05:10:34 -0400
Message-ID: <3D2957A9.6D90A916@cs.curtin.edu.au>
Date: Mon, 08 Jul 2002 17:13:13 +0800
From: Patrick Clohessy <pat@cs.curtin.edu.au>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: spurious 8259A interrupt: IRQ7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I was just wondering if anyone could help me solve a problem I'm having.
I have installed red hat 7.3 with kernel version 2.4.18 on an AMD Duron
1100 with a ASUS A7V133-C Motherboard, 32MB TNT2 and a 20 GIG Maxtor
Viper HD. Whenever the machine boots up, the following error appears :

spurious 8259A interrupt: IRQ7

I have read through quite a few mailing lists and other sources but
can't find an adequate solution. One solution I found was to turn off
Local APIC support and IO-APIC support in the kernel, which I tried and
it worked, but I'd rather not do this. I realise the error isn't of a
huge concern but it's still annoying having it appear everytime the
machine boots up.

Any help will be greatly appreciated.

Thanks


--
Patrick Clohessy
Curtin University of Technology
School of Computing
Tel: +61 8 9266 2986
email: pat@cs.curtin.edu.au


