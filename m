Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264961AbTF1AK3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 20:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264966AbTF1AK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 20:10:28 -0400
Received: from web40605.mail.yahoo.com ([66.218.78.142]:21359 "HELO
	web40605.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264961AbTF1AKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 20:10:24 -0400
Message-ID: <20030628002439.92686.qmail@web40605.mail.yahoo.com>
Date: Fri, 27 Jun 2003 17:24:39 -0700 (PDT)
From: Miles T Lane <miles_lane@yahoo.com>
Subject: 2.5.73-bk5 -- drivers/media/video/zr36120.h:29:27: linux/i2c-old.h: No such file or directory
To: linux-kernel@vger.kernel.org, Pauline Middelink <middelin@polyware.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC [M]  drivers/media/video/zr36120.o
drivers/media/video/zr36120.c:42:19: tuner.h: No such
file or directory
In file included from
drivers/media/video/zr36120.c:43:
drivers/media/video/zr36120.h:29:27: linux/i2c-old.h:
No such file or directory
In file included from
drivers/media/video/zr36120.c:43:
drivers/media/video/zr36120.h:101: error: field `i2c'
has incomplete type
drivers/media/video/zr36120.c: In function
`zoran_muxsel':
drivers/media/video/zr36120.c:392: warning: implicit
declaration of function `i2c_control_device'
drivers/media/video/zr36120.c:392: error:
`I2C_DRIVERID_VIDEODECODER' undeclared (first use in
this function)


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
