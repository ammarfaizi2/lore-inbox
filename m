Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266969AbRGHTyR>; Sun, 8 Jul 2001 15:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266970AbRGHTyH>; Sun, 8 Jul 2001 15:54:07 -0400
Received: from fes3.whowhere.com ([209.185.123.188]:34519 "HELO mailcity.com")
	by vger.kernel.org with SMTP id <S266969AbRGHTx6>;
	Sun, 8 Jul 2001 15:53:58 -0400
To: linux-kernel@vger.kernel.org
Date: Sun, 08 Jul 2001 12:53:37 -0700
From: "Williams  Karl" <karlg3@lycos.com>
Message-ID: <PJPLKKGEPDGOAAAA@mailcity.com>
Mime-Version: 1.0
X-Sent-Mail: off
Reply-To: karlg3@lycos.com
X-Mailer: MailCity Service
Subject: opening, reading, writing to file from kernel
X-Sender-Ip: 64.164.126.43
Organization: Lycos Mail  (http://mail.lycos.com:80)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need to change the data field in select outgoing TCP packets with information from a data file in user space.  I think the easiest way to do this would be to replace the pointer to skb->data with a pointer to the applicable portion of my data file.  But, I'm not clear on how to do this.  

I'd prefer just to do a sys_open() or some other file open command to gain access to my data file.

Any ideas?  I apologize, but, I am by no means a kernel level programmer.  I'm just trying to get the kernel to do this one little thing.

Thanks in advance for any specific examples


Get 250 color business cards for FREE!
http://businesscards.lycos.com/vp/fastpath/
