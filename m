Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281714AbRKQInS>; Sat, 17 Nov 2001 03:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281715AbRKQInI>; Sat, 17 Nov 2001 03:43:08 -0500
Received: from smtp-rt-14.wanadoo.fr ([193.252.19.224]:51685 "EHLO
	adansonia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S281714AbRKQImy>; Sat, 17 Nov 2001 03:42:54 -0500
Message-ID: <3BF622F7.C041D031@wanadoo.fr>
Date: Sat, 17 Nov 2001 09:42:31 +0100
From: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.15-pre5 i586)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.2.15-pre5, slowdown, kapm-idled 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Time to time, the system slowdown.
Everything become _very_ slow.
At these moments, I can see that kapm-idled is eating about 65% of the
cpu.

System is : K6-2 500, 384Mb SDRAM 

Linux debian-f5ibh 2.4.15-pre5 #1 ven nov 16 13:25:39 CET 2001 i586
unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11l
mount                  2.11l
modutils               2.4.10
e2fsprogs              1.25
reiserfsprogs          3.x.0j
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         ppp_deflate bsd_comp ppp_async ppp_generic slhc
af_packet scc ax25 usb-ohci usbcore nfsd lockd sunrpc serial parport_pc
lp parport autofs4 es1371 soundcore ac97_codec gameport w83781d i2c-proc
i2c-isa i2c-core rtc unix

I can give any other information upon request
------------
Regards

		Jean-Luc
