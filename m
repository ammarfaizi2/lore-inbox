Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136617AbREJN7q>; Thu, 10 May 2001 09:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136641AbREJN7g>; Thu, 10 May 2001 09:59:36 -0400
Received: from zeus.kernel.org ([209.10.41.242]:54674 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S136638AbREJN7W>;
	Thu, 10 May 2001 09:59:22 -0400
Date: Wed, 9 May 2001 20:57:01 -0700
Message-Id: <200105100357.UAA16327@mail25.bigmailbox.com>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
X-Mailer: MIME-tools 4.104 (Entity 4.116)
Mime-Version: 1.0
X-Originating-Ip: [202.67.238.249]
From: "Jacky Liu" <jq419@my-deja.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.4 kernel freeze for unknown reason
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,
 
I would like to post a question regarding to a problem of unknown freeze of my linux firewall/gateway.
 
Here is the hardware configuration of my machine:
 
AMD K-6 233 MHz
2theMax P-55 VP3 mobo
64Mb RAM in a single module (PC-100)
Maxtor 6G UDMA-33 harddisk
Matrox MG-II display card w/8Mb RAM
3Com 3C905B-TX NIC
RealTek 8129 10/100 NIC
 
It's running 2.4.4 kernel (RedHat 7.1) and acting as a firewall using Netfilter (gShield and Snort), DNS (Cache-Only DNS) and NAT gateway (ip-masq.) for my home network. I used 3C905B-TX NIC as my internal NIC and RealTek 8129 as my external NIC. Here is the problem:
 
The machine has been randomly lockup (totally freeze) for number of times without any traceable clue or error message. Usually the time frame between each lockup is between 24 to 72 hours. The screen just freeze when it's lockup (either in Console or X) and no "kernel panic" type or any error message prompt up. All services (SSH, DNS, etc..) are dead when it's lockup and I cannot find any useful information in /var/log/messages. I cannot reproduce the lockup since it's totally randomly. The lockup happened either when I was playing online game (A LOT, like getting thousands of server status in counter-strike in a very short time frame, of NAT traffic), surfing the web (normal traffic) or the machine was totally in idle (lockup when I was sleeping). It was lockup this morning when I was playing online game (when my game machine was trying to establish connection to a game server).
 
If there is any information you would like to obtain, please let me know. I would like to receive a copy of your reply, thank you very much for your kindly attention.
 
Best Regards,
Jacky Liu
 
"Genius or Wacko? Majority or Minority… "

------------------------------------------------------------
--== Sent via Deja.com ==--
http://www.deja.com/
