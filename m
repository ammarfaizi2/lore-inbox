Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266760AbSKQXYw>; Sun, 17 Nov 2002 18:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266980AbSKQXYw>; Sun, 17 Nov 2002 18:24:52 -0500
Received: from imo-m09.mx.aol.com ([64.12.136.164]:32510 "EHLO
	imo-m09.mx.aol.com") by vger.kernel.org with ESMTP
	id <S266760AbSKQXYv>; Sun, 17 Nov 2002 18:24:51 -0500
Message-ID: <3DD827C2.1020601@netscape.net>
Date: Mon, 18 Nov 2002 00:35:30 +0100
From: =?ISO-8859-1?Q?Gustavo_Puche_Rodr=EDguez?= <GeenHavok@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: es
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Problem with USB]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



    I have a 2.4.18 kernel and a motherboar EliteGroup K76SA, in the 
boot messages apear a failure with the USB. This failure can be seen below:

usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-ohci.c: USB OHCI at membase 0xe08b7000, IRQ 9
usb-ohci.c: usb-00:02.2, Silicon Integrated Systems [SiS] 7001
usb.c: new USB bus registered, assigned bus number 1
usb-ohci.c: USB OHCI at membase 0xe08b9000, IRQ 5
usb-ohci.c: usb-00:02.3, Silicon Integrated Systems [SiS] 7001 (#2)
usb.c: new USB bus registered, assigned bus number 2
usb.c: registered new driver usblp
usb_control/bulk_msg: timeout
usb-ohci.c: unlink URB timeout
usb.c: USB device not accepting new address=2 (error=-110)
usb_control/bulk_msg: timeout
usb-ohci.c: unlink URB timeout
usb.c: USB device not accepting new address=3 (error=-110)
 
Can anybody tell me if there is a fix of the BIOS or same other help?

ThanKs!!!

    Gus.



