Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317599AbSHHPXg>; Thu, 8 Aug 2002 11:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317598AbSHHPXg>; Thu, 8 Aug 2002 11:23:36 -0400
Received: from pop.gmx.net ([213.165.64.20]:807 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317599AbSHHPWj>;
	Thu, 8 Aug 2002 11:22:39 -0400
Date: Thu, 8 Aug 2002 17:29:55 +0200
From: gigerstyle@gmx.ch
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: /proc/net/dev and ifconfig
Message-Id: <20020808172955.7af1bea1.gigerstyle@gmx.ch>
X-Mailer: Sylpheed version 0.8.1claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

A little question:

I have a little server with kernel 2.4.16 running (without any problems, very stable).

I noticed that when approximately 4 GB data are received (over Ethernet) then the counter in /proc/net/dev again begins to count from zero. 
Is it normal? Does it depend on the Ethernet-Card? 
It's a Realtek Semiconductor Co., Ltd. RTL-8029(AS)

Should I update the kernel?

greets

Marc
