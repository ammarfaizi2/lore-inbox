Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316446AbSGVGVA>; Mon, 22 Jul 2002 02:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316465AbSGVGVA>; Mon, 22 Jul 2002 02:21:00 -0400
Received: from 205-158-62-80.outblaze.com ([205.158.62.80]:54533 "HELO
	ws1-11.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S316446AbSGVGVA>; Mon, 22 Jul 2002 02:21:00 -0400
Message-ID: <20020722062402.65938.qmail@mail.com>
Content-Type: multipart/mixed; boundary="----------=_1027319042-54154-0"
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Ana Yuseepi" <anayuseepi@asia.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 22 Jul 2002 01:24:02 -0500
Subject: ATA with SMART
X-Originating-Ip: 210.159.65.4
X-Originating-Server: ws1-11.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format...

------------=_1027319042-54154-0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hello everyone,
 
I would like to send some SMART commands in linux. One of the command I'd like to send is return_smart_status and I needed some extra data that the device would return in Cylinder_Low and Cylinder_High registers. 
 
I have tried to use the HDIO_DRIVE_CMD, but I think this can't help me with the above operation.
 
I tried using the inw_p and outw_p, inb_p, outb_p, but with these, i usually receive the "lost interrupt" message.
 
Does anyone here have suggestions on what i should do?

Please reply, and thank you for your time,

-Ana
-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

Save up to $160 by signing up for NetZero Platinum Internet service.
http://www.netzero.net/?refcd=N2P0602NEP8


------------=_1027319042-54154-0--
