Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136100AbRAMB7f>; Fri, 12 Jan 2001 20:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136084AbRAMB7Z>; Fri, 12 Jan 2001 20:59:25 -0500
Received: from [156.46.206.66] ([156.46.206.66]:42432 "EHLO eagle.netwrx1.com")
	by vger.kernel.org with ESMTP id <S136076AbRAMB7M>;
	Fri, 12 Jan 2001 20:59:12 -0500
From: "George R. Kasica" <georgek@netwrx1.com>
To: Dan B <db@cyclonehq.dnsalias.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [eepro100] Ok, I'm fed up now
Date: Fri, 12 Jan 2001 19:59:10 -0600
Organization: Netwrx Consulting Inc.
Reply-To: georgek@netwrx1.com
Message-ID: <redv5todmdr2ipqgc8qf59ervtgq993fuo@4ax.com>
In-Reply-To: <LAW2-F8403oHMwVN7mi0000e9c6@hotmail.com> <LAW2-F8403oHMwVN7mi0000e9c6@hotmail.com> <20010111141435.C12616@valinux.com> <5.0.2.1.0.20010112153102.021f34e8@10.0.0.254>
In-Reply-To: <5.0.2.1.0.20010112153102.021f34e8@10.0.0.254>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using the following and its been flawless under 2.4x:

eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/driv
ers/eepro100.html
eepro100.c: $Revision: 1.35 $ 2000/11/17 Modified by Andrey V.
Savochkin <saw@sa
w.sw.com.sg> and others
PCI: Found IRQ 11 for device 00:0b.0
eth0: Intel Corporation 82557 [Ethernet Pro 100], 00:02:B3:1C:53:67,
IRQ 11.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 721383-016, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).


>Has anyone gotten Intel's (non-GPL) e100 driver working in 2.4.x yet?  What 
>about their e100-ANS driver that supports FEC 800mbps?

George

===[George R. Kasica]===        +1 262 513 8503
President                       +1 206 374 6482 FAX 
Netwrx Consulting Inc.          Waukesha, WI USA 
http://www.netwrx1.com
georgek@netwrx1.com
ICQ #12862186
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
