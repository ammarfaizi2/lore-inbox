Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbTAEDuS>; Sat, 4 Jan 2003 22:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262806AbTAEDuS>; Sat, 4 Jan 2003 22:50:18 -0500
Received: from air-2.osdl.org ([65.172.181.6]:42426 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262796AbTAEDuQ>;
	Sat, 4 Jan 2003 22:50:16 -0500
Date: Sat, 4 Jan 2003 19:55:40 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
cc: <linux-kernel@vger.kernel.org>
Subject: RE: [STUPID] Best looking code to transfer to a t-shirt
In-Reply-To: <Pine.LNX.4.44.0301041446560.18708-100000@dns.toxicfilms.tv>
Message-ID: <Pine.LNX.4.33L2.0301041954400.3599-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Jan 2003, Maciej Soltysiak wrote:

| Thank you all for your suggestions, i found this very entertaining, lot
| of laughs i must say. Also the ammount of 'shit' and 'fuck' words totally
| blew me off :)
|
| I think i'll put on my t-shirt:
| - panic()
| - risc logos (on the sides)
| - printer "on fire" line (btw. 2.4.20 doesn't have "on fire", just:
|   "unknown error", 2.5.54 has it in drivers/usb/class/usblp.c)
2.4.2 drivers/char/lp.c, line 209, has:
			printk(KERN_INFO "lp%d on fire\n", minor);

| - the elegant idle routine - also nice to have. maybe on the back

-- 
~Randy

