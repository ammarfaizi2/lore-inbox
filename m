Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280834AbRKONy3>; Thu, 15 Nov 2001 08:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280836AbRKONyT>; Thu, 15 Nov 2001 08:54:19 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:13960 "EHLO
	c0mailgw13.prontomail.com") by vger.kernel.org with ESMTP
	id <S280834AbRKONyC>; Thu, 15 Nov 2001 08:54:02 -0500
Message-ID: <3BF3C8DC.C8FE24B8@starband.net>
Date: Thu, 15 Nov 2001 08:53:33 -0500
From: war <war@starband.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: System Locks Temporarily When Untarring Large Files
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to mention.

Type of Drive:
The hard drive is a 40GB IBM-DTLA-305040.

Speed of Drive:
When many apps are open I get:
Timing buffered disk reads:  64 MB in  2.55 seconds = 25.10 MB/sec
When I am in single user mode, I get 29.50MB/s.

Drive Information:
# hdparm -v /dev/hda

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 5005/255/63, sectors = 80418240, start = 0


