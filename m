Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263752AbRFMOLu>; Wed, 13 Jun 2001 10:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263772AbRFMOLc>; Wed, 13 Jun 2001 10:11:32 -0400
Received: from smtp-server1.tampabay.rr.com ([65.32.1.34]:44250 "EHLO
	smtp-server1.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S263752AbRFMOLN>; Wed, 13 Jun 2001 10:11:13 -0400
Message-ID: <3B277466.810648BE@tampabay.rr.com>
Date: Wed, 13 Jun 2001 10:10:46 -0400
From: guviegha <guviegha@tampabay.rr.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: incomplete boot?
Content-Type: multipart/mixed;
 boundary="------------FE00658E7B5388B28AED8F3A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------FE00658E7B5388B28AED8F3A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

  I cannot get the new kernel I built to boot completely.
It hangs after printing this message to screen.
NET4: Unix domain sockets 1.0/SMP For Linux 4.0
It also appears it cannot mount the file system.
How do I get log messages for complete and incomplete sessions?

Thanks
Godwin

--------------FE00658E7B5388B28AED8F3A
Content-Type: text/plain; charset=us-ascii;
 name="f_file"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="f_file"

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux 65340hfc116.tampabay.rr.com 2.4.2-2 #1 Sun Apr 8 20:41:30 EDT 2001 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.10r
modutils               2.4.2
e2fsprogs              1.19
PPP                    2.4.0
isdn4k-utils           3.1pre1
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         sd_mod sr_mod usbkbd autofs 8139too ipchains ide-scsi scsi_mod ide-cd cdrom mousedev keybdev hid input usb-uhci usbcore

--------------FE00658E7B5388B28AED8F3A--

