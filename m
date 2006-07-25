Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWGYUTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWGYUTO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 16:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbWGYUTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 16:19:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51328 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932274AbWGYUTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 16:19:12 -0400
Date: Tue, 25 Jul 2006 13:17:59 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: Typo in ub clause of devices.txt
Message-Id: <20060725131759.14fdcd7e.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace "thrid" with "third".

Signed-off-by: Pete Zaitcev

diff -urp -X dontdiff linux-2.6.18-rc1/Documentation/devices.txt linux-2.6.18-rc1-lem/Documentation/devices.txt
--- linux-2.6.18-rc1/Documentation/devices.txt	2006-07-09 17:53:25.000000000 -0700
+++ linux-2.6.18-rc1-lem/Documentation/devices.txt	2006-07-09 20:12:03.000000000 -0700
@@ -2565,10 +2565,10 @@ Your cooperation is appreciated.
 		243 = /dev/usb/dabusb3	Fourth dabusb device
 
 180 block	USB block devices
-		0 = /dev/uba		First USB block device
-		8 = /dev/ubb		Second USB block device
-		16 = /dev/ubc		Thrid USB block device
-		...
+		  0 = /dev/uba		First USB block device
+		  8 = /dev/ubb		Second USB block device
+		 16 = /dev/ubc		Third USB block device
+		    ...
 
 181 char	Conrad Electronic parallel port radio clocks
 		  0 = /dev/pcfclock0	First Conrad radio clock
