Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293521AbSCCHWj>; Sun, 3 Mar 2002 02:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293522AbSCCHWa>; Sun, 3 Mar 2002 02:22:30 -0500
Received: from lysimachus.hosting.pacbell.net ([216.100.98.17]:34793 "EHLO
	lysimachus.hosting.pacbell.net") by vger.kernel.org with ESMTP
	id <S293521AbSCCHWO>; Sun, 3 Mar 2002 02:22:14 -0500
From: "Adam Khan" <adam.khan@cavium.com>
To: <linux-kernel@vger.kernel.org>
Subject: newbie - netif_rx() issue
Date: Sat, 2 Mar 2002 23:17:06 -0800
Message-ID: <000301c1c283$6f406500$4310a8c0@Adamspc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Running Linux 7.1 with FreeS/WAN 1.91
> 
> I am working on some HW acceleration stuff - Ive got the transmit
> side working (pings to another machine and receive the response).
> Ive been working on the receive side - it looks as if the packet
> received is decrypted correctly and then the netif_rx() routine gets
> called. I see the message "ipsec_rcv: netif_rx() called" in the logs. 
> Don't get a response. After the first packet, packet processing seems
to 
> get into the receive routine not to the same point.

> I could really use some insight to get this resolved!
> 
> Thanks in advance,
> Adam
>

Adam 



