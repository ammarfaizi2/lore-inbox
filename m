Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265006AbTF1AaP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 20:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264994AbTF1A0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 20:26:48 -0400
Received: from web40606.mail.yahoo.com ([66.218.78.143]:56219 "HELO
	web40606.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264975AbTF1A0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 20:26:14 -0400
Message-ID: <20030628004029.52426.qmail@web40606.mail.yahoo.com>
Date: Fri, 27 Jun 2003 17:40:29 -0700 (PDT)
From: Miles T Lane <miles_lane@yahoo.com>
Subject: 2.5.73-bk5 -- drivers/scsi/tmscsim.c:872: error: structure has no member named `next'
To: linux-kernel@vger.kernel.org, ching@tekram.com.tw,
       Kurt Garloff <garloff@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC [M]  drivers/scsi/tmscsim.o
drivers/scsi/tmscsim.c: In function
`dc390_Query_append':
drivers/scsi/tmscsim.c:872: error: structure has no
member named `next'
drivers/scsi/tmscsim.c:877: error: structure has no
member named `next'
drivers/scsi/tmscsim.c: In function `dc390_Query_get':
drivers/scsi/tmscsim.c:889: error: structure has no
member named `next'
drivers/scsi/tmscsim.c:890: error: structure has no
member named `next'
drivers/scsi/tmscsim.c: In function
`DC390_waiting_timed_out':
drivers/scsi/tmscsim.c:1074: error: request for member
`pScsiHost' in something not a structure or union
drivers/scsi/tmscsim.c:1078: error: request for member
`pScsiHost' in something not a structure or union
drivers/scsi/tmscsim.c: In function `dc390_BuildSRB':
drivers/scsi/tmscsim.c:1146: error: structure has no
member named `address'

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
