Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288071AbSCOJlU>; Fri, 15 Mar 2002 04:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288012AbSCOJlL>; Fri, 15 Mar 2002 04:41:11 -0500
Received: (root@vger.kernel.org) by vger.kernel.org id <S288071AbSCOJk7>;
	Fri, 15 Mar 2002 04:40:59 -0500
Received: from web14706.mail.yahoo.com ([216.136.224.123]:269 "HELO
	web14706.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S311809AbSCNVl1>; Thu, 14 Mar 2002 16:41:27 -0500
Message-ID: <20020314214125.58646.qmail@web14706.mail.yahoo.com>
Date: Thu, 14 Mar 2002 13:41:25 -0800 (PST)
From: Jing Xu <xujing_cn2001@yahoo.com>
Subject: need help: radeonfb problem
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I met some problem with radeonfb driver.I use two
graphic cards on my box
PCI:00:0e:0  ATI rage XL (pci)
PCI:01:00:0  ATI radeon QY VE (AGP)

and I use radeonfb as the frame buffer device driver
for ATI radeon. Radeonfb driver are built in the
kernel, not as a module. When booting system, there
are messages like that:

    radeonfb: ref_clk=2700, ref_div=12, xclk=18300;
    cannot map FB;

But if I only use the ATI radeon card and plug out the
pci one, this driver works very well.

what's the problem?

I use redhat 7.2 and kernel 2.4.14 on i386.
In addition to this, I would be glad to know about
configuring the IRQ table in linux.

Thanks in advance,

jing



__________________________________________________
Do You Yahoo!?
Yahoo! Sports - live college hoops coverage
http://sports.yahoo.com/

