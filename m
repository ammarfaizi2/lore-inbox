Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264973AbTF1ASW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 20:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264982AbTF1ASW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 20:18:22 -0400
Received: from web40601.mail.yahoo.com ([66.218.78.138]:34128 "HELO
	web40601.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264973AbTF1AST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 20:18:19 -0400
Message-ID: <20030628003234.18723.qmail@web40601.mail.yahoo.com>
Date: Fri, 27 Jun 2003 17:32:34 -0700 (PDT)
From: Miles T Lane <miles_lane@yahoo.com>
Subject: 2.5.73-bk5 -- drivers/scsi/cpqfcTSinit.c:951: error: structure has no member named `channel'
To: linux-kernel@vger.kernel.org, Michael Griffith <grif@cs.ucr.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC [M]  drivers/scsi/cpqfcTSinit.o
drivers/scsi/cpqfcTSinit.c: In function
`cpqfcTS_proc_info':
drivers/scsi/cpqfcTSinit.c:951: error: structure has
no member named `channel'
drivers/scsi/cpqfcTSinit.c:953: error: structure has
no member named `target'
drivers/scsi/cpqfcTSinit.c: In function
`cpqfcTS_TargetDeviceReset':
drivers/scsi/cpqfcTSinit.c:1598: warning: implicit
declaration of function `scsi_do_cmd'
make[2]: *** [drivers/scsi/cpqfcTSinit.o] Error 1

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
