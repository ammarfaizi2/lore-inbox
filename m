Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264991AbTF1AXZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 20:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264975AbTF1AXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 20:23:05 -0400
Received: from web40610.mail.yahoo.com ([66.218.78.147]:16968 "HELO
	web40610.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265007AbTF1AVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 20:21:41 -0400
Message-ID: <20030628003556.53308.qmail@web40610.mail.yahoo.com>
Date: Fri, 27 Jun 2003 17:35:56 -0700 (PDT)
From: Miles T Lane <miles_lane@yahoo.com>
Subject: 2.5.73-bk5 -- drivers/scsi/pci2000.c:512: error: structure has no member named `address'
To: linux-kernel@vger.kernel.org, tech@psidisk.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC [M]  drivers/scsi/pci2000.o
drivers/scsi/pci2000.c: In function
`Pci2000_QueueCommand':
drivers/scsi/pci2000.c:512: error: structure has no
member named `address'
drivers/scsi/pci2000.c:537: error: structure has no
member named `address'
make[2]: *** [drivers/scsi/pci2000.o] Error 1

Gnu C                  3.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11x
e2fsprogs              1.34-WIP
jfsutils               1.1.1
xfsprogs               2.4.12
pcmcia-cs              3.2.2
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.9
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         3c59x parport_pc lp parport
soundcore ipx mousedev hid usbmouse input md usb-ohci
autofs4 af_packet nls_iso8859-1 nls_cp437 serial
usb-uhci usbcore ds yenta_socket pcmcia_core apm rtc
ext3 jbd


__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
