Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265365AbUBIXTi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265375AbUBIXTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:19:38 -0500
Received: from mail.kroah.org ([65.200.24.183]:46523 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265365AbUBIXTd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:19:33 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.3-rc1
In-Reply-To: <10763687752678@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:19:35 -0800
Message-Id: <10763687753233@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500.11.7, 2004/02/05 17:04:24-08:00, khali@linux-fr.org

[PATCH] I2C: Update I2C maintainers entry

I propose the following update of the "I2C AND SENSORS DRIVERS" entry in
MAINTAINERS:

* Remove Frodo Looijaard. He isn't active in the project anymore, and
forwards everythings he receives to the mailing-list. More work for
everyone, and increased latency.

* Move your name to the top. This is more realistic since you are the
real maintainer of the i2c subsystem in 2.6.

* Reindent. Spaces were used instead of tabs.


 MAINTAINERS |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)


diff -Nru a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	Mon Feb  9 15:05:41 2004
+++ b/MAINTAINERS	Mon Feb  9 15:05:41 2004
@@ -922,15 +922,13 @@
 S:	Maintained
 
 I2C AND SENSORS DRIVERS
-P:      Frodo Looijaard
-M:      frodol@dds.nl
-P:      Philip Edelbrock
-M:      phil@netroedge.com
 P:	Greg Kroah-Hartman
 M:	greg@kroah.com
-L:      sensors@stimpy.netroedge.com
-W:      http://www.lm-sensors.nu/
-S:      Maintained
+P:	Philip Edelbrock
+M:	phil@netroedge.com
+L:	sensors@stimpy.netroedge.com
+W:	http://www.lm-sensors.nu/
+S:	Maintained
 
 i386 BOOT CODE
 P:	Riley H. Williams

