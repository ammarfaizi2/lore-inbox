Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268755AbTCCUCI>; Mon, 3 Mar 2003 15:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268756AbTCCUCI>; Mon, 3 Mar 2003 15:02:08 -0500
Received: from bimba.bezeqint.net ([192.115.106.39]:15529 "EHLO
	bimba.bezeqint.net") by vger.kernel.org with ESMTP
	id <S268755AbTCCUCI>; Mon, 3 Mar 2003 15:02:08 -0500
From: "Elie" <welie@bezeqint.net>
To: <linux-kernel@vger.kernel.org>
Subject: wait_on_buffer 
Date: Mon, 3 Mar 2003 22:06:15 +0200
Message-ID: <JLEOIKOLJCFPEIJOOOECOEIHCEAA.welie@bezeqint.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It has been 40 hours since my post about cp -a hanging on my drive. I
haven't gotten a response, and I assume based on the traffic on this list, I
am not going to get one. So I really could use some help, and if anyone can
help me to get this hard disk to work I would appreiciate it. If there is
another list I can try for more help please let me know. To sum up, I cp -a
hangs at random times. ps shows wait_on_buffer on etx3/ get_grequest after I
reformatted the partitions to ext2. One time the entire system froze. There
are no errors in any logs. The hd is a Maxtor 91360U4 with 13g. Kernel is
2.4-18. Red Hat 8.0.

The drive worked well on a mac just a few days ago. Formated it for Windows
and tested copying many files and had no problems. Scandisk reports no
problems. So it seems to me to be a problem with linux, but I couldn't begin
to figure what I should do.

Thanks,
Elie.


