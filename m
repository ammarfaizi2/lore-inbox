Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290413AbSAPLNv>; Wed, 16 Jan 2002 06:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290412AbSAPLNl>; Wed, 16 Jan 2002 06:13:41 -0500
Received: from gw.wizards.com ([209.221.142.132]:59304 "EHLO
	fungusaur.wizards.com") by vger.kernel.org with ESMTP
	id <S289124AbSAPLN2>; Wed, 16 Jan 2002 06:13:28 -0500
Message-Id: <5.1.0.14.0.20020116115713.00a96ec0@popmail.libero.it>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 16 Jan 2002 12:13:11 +0100
To: linux-kernel@vger.kernel.org
From: Luca Adesso <ladesso@libero.it>
Subject: iptables and 2.4.17
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is some problem with iptables modules and kernel 2.4.17 ?
I'm using 2.4.10 and it works fine; I tried on another computer at work the 
2.4.17 but I got unresolved symbol errors
ip_tables.o: unresolved symbol nf_unregister_sockopt
ip_tables.o: unresolved symbol nf_register_sockopt

I downloaded 2.4.16 and compiled with the same configuration and it works fine.
I have Slackware 7.0

Please CC me for the reply.
Thanks.

