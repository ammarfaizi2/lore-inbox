Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132652AbRDQOY0>; Tue, 17 Apr 2001 10:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132660AbRDQOYR>; Tue, 17 Apr 2001 10:24:17 -0400
Received: from mail.cis.nctu.edu.tw ([140.113.23.5]:27410 "EHLO
	mail.cis.nctu.edu.tw") by vger.kernel.org with ESMTP
	id <S132652AbRDQOYD>; Tue, 17 Apr 2001 10:24:03 -0400
Message-ID: <004901c0c74a$c50880b0$ae58718c@cis.nctu.edu.tw>
Reply-To: "gis88530" <gis88530@cis.nctu.edu.tw>
From: "gis88530" <gis88530@cis.nctu.edu.tw>
To: <linux-kernel@vger.kernel.org>
Subject: icmp and port 
Date: Tue, 17 Apr 2001 22:28:53 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have study the code in ip_masq.c, and
I found that icmp packet use 
source address, destination address, source port and
destination port to hash into masquerade table.

Do icmp packets have port information?
I have print the port information with printk,
but I can't find out the answer to this question.
Could you give me a hint? Thanks a lot.

Cheers,
Tom

