Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315807AbSENQZG>; Tue, 14 May 2002 12:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315811AbSENQZD>; Tue, 14 May 2002 12:25:03 -0400
Received: from h24-71-223-10.cg.shawcable.net ([24.71.223.10]:291 "EHLO
	pd2mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id <S315807AbSENQY6>; Tue, 14 May 2002 12:24:58 -0400
Date: Tue, 14 May 2002 12:23:35 -0700
From: Andre LeBlanc <ap.leblanc@shaw.ca>
Subject: No Network, 2.4.19-pre8
To: linux-kernel@vger.kernel.org
Message-id: <000701c1fb7c$d80c3640$2000a8c0@metalbox>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried every fix I've found on Usenet for not having a network
connection after recompiling your kernel but nothing has seemed to work.
the reason i'm posting it to this list is because if I boot the old (2.2.20)
kernel from lilo my network connection is fine, but if I boot the new one
(2.4.19-pre8) I have no network connection at all!  dmesg shows that the
cards are detected perfectly, the drivers are compiled into the kernel and I
also compiled in "Socket Filter" because I was told that it might work, but
I still can't ping my firewall.  I don't know what else to try, does anyone
have any ideas?  BTW its debian-woody


