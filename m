Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316355AbSFUWGp>; Fri, 21 Jun 2002 18:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316404AbSFUWGo>; Fri, 21 Jun 2002 18:06:44 -0400
Received: from webo.vtcif.telstra.com.au ([202.12.144.19]:48805 "EHLO
	webo.vtcif.telstra.com.au") by vger.kernel.org with ESMTP
	id <S316355AbSFUWGn>; Fri, 21 Jun 2002 18:06:43 -0400
Message-ID: <73388857A695D31197EF00508B08F29807216B5F@ntmsg0131.corpmail.telstra.com.au>
From: "Lu, Yan P" <Yan-Ping.Lu@team.telstra.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: FW:  netgear ga621
Date: Sat, 22 Jun 2002 08:06:18 +1000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello 

> I have got trouble with netgear ga621. I am running redhat 7.3 which the
> kernel version is 2.4.18-3. I successfully compiled driver provided by
> netgear, but could not get card works. I used the following command to
> load the driver[1]:
> [1]:
>  # insmod gam.o
> 
> Then, I have got link LED on the card goes off, and /var/log/message only
> shows the following message[2]:
> [2]:
> Jun 22 07:37:51 AN131 kernel: NETGEAR GA621 Gigabit Fiber Adapter Driver,
> version 1.02, May 15 2001, linux 2.4.x kernel
> Jun 22 07:37:51 AN131 kernel: 
> Jun 22 07:37:51 AN131 kernel: NETGEAR GA621 Gigabit Fiber Adapter : eth1
> Jun 22 07:37:51 AN131 kernel: 
> Jun 22 07:37:51 AN131 kernel: NETGEAR GA621 Gigabit Fiber Adapter : eth2
> 
> I have also used the command to active the card[3]:
> [3]:
> # ifconfig eth1 10.2.2.2
> 
> log/message does not do any changes, and link LED is still off.
> 
Anyone can tell me how to make this card works. 
> *	what's the configuration I need to do to make this card works, 
> *	which configuration points I can check, 
> *	what's the proper log message I should see if the card works ok. 
> 
> Thank you in advance for your help.
> 
> Regards,
> Yan
