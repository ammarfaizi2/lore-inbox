Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbTEGAUu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 20:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbTEGATR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 20:19:17 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:65164 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262121AbTEGATL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 20:19:11 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10522676151566@kroah.com>
Subject: Re: [PATCH] i2c driver changes for 2.5.69
In-Reply-To: <10522676152488@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 6 May 2003 17:33:35 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1042.48.4, 2003/04/29 10:19:14-07:00, greg@kroah.com

i2c: fix up the MAINTAINERS i2c entry

Removed the dead web page and email address, and merged with the sensors entry
and added myself.


 MAINTAINERS |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)


diff -Nru a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	Tue May  6 17:24:51 2003
+++ b/MAINTAINERS	Tue May  6 17:24:51 2003
@@ -790,20 +790,13 @@
 M:	drivers@neukum.org
 S:	Maintained
 
-I2C DRIVERS
-P:	Simon Vogl
-M:	simon@tk.uni-linz.ac.at
-P:	Frodo Looijaard
-M:	frodol@dds.nl
-L:	linux-i2c@pelican.tk.uni-linz.ac.at
-W:	http://www.tk.uni-linz.ac.at/~simon/private/i2c
-S:	Maintained
-
-SENSORS DRIVERS
+I2C AND SENSORS DRIVERS
 P:      Frodo Looijaard
 M:      frodol@dds.nl
 P:      Philip Edelbrock
 M:      phil@netroedge.com
+P:	Greg Kroah-Hartman
+M:	greg@kroah.com
 L:      sensors@stimpy.netroedge.com
 W:      http://www.lm-sensors.nu/
 S:      Maintained

