Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263661AbTCURFl>; Fri, 21 Mar 2003 12:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263662AbTCURFl>; Fri, 21 Mar 2003 12:05:41 -0500
Received: from franka.aracnet.com ([216.99.193.44]:49042 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263661AbTCURFk>; Fri, 21 Mar 2003 12:05:40 -0500
Date: Fri, 21 Mar 2003 09:16:40 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 481] New: Annoying full pathname prefixes before messages during boot.
Message-ID: <335630000.1048267000@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=481

           Summary: Annoying full pathname prefixes before messages during
                    boot.
    Kernel Version: 2.5.65
            Status: NEW
          Severity: low
             Owner: greg@kroah.com
         Submitter: davej@codemonkey.org.uk


drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
drivers/usb/core/usb.c: registered new driver ov511
drivers/usb/media/ov511.c: v1.64 for Linux 2.5 : ov511 USB Camera Driver
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
drivers/usb/core/usb.c: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for Handspring
Visor / Treo / Palm 4.0 / Cli<E9> 4.x
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony Cli<E9> 3.5
drivers/usb/core/usb.c: registered new driver visor
drivers/usb/serial/visor.c: USB HandSpring Visor, Palm m50x, Sony Cli<E9> driver
v2.1


