Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268998AbTGJG5x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 02:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269006AbTGJG5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 02:57:53 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:19466 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S268998AbTGJG5h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 02:57:37 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: linux-kernel@vger.kernel.org
Subject: 2.5.74 CONFIG_USB_SERIAL_CONSOLE gone?
Date: Thu, 10 Jul 2003 14:53:57 +0800
User-Agent: KMail/1.5.2
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307101453.57857.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tried to config usb serial console on 2.5.74 but it's no more configurable.

Searched the tree and these are the only references

./BitKeeper/deleted/.del-Config.help~23cda2581f02cfcb
./BitKeeper/deleted/.del-Config.in~92fe774f90db89d
./drivers/usb/serial/Makefile
./drivers/usb/serial/usb-serial.h

Has this been deleted?

Regards
Michael

-- 
Powered by linux-2.5.74-mm3. Compiled with gcc-2.95-3 - mature and rock solid

My current linux related activities:
- 2.5 yenta_socket testing
- Test development and testing of swsusp for 2.4/2.5 and ACPI S3 of 2.5 kernel 
- Everyday usage of 2.5 kernel

More info on 2.5 kernel: http://www.codemonkey.org.uk/post-halloween-2.5.txt
More info on swsusp: http://sourceforge.net/projects/swsusp/

