Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261395AbSJHXPy>; Tue, 8 Oct 2002 19:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261721AbSJHXOx>; Tue, 8 Oct 2002 19:14:53 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:50185 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261493AbSJHXOC>;
	Tue, 8 Oct 2002 19:14:02 -0400
Date: Tue, 8 Oct 2002 16:15:57 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] USB and driver core changes for 2.5.41
Message-ID: <20021008231557.GB11337@kroah.com>
References: <20021008231511.GA11337@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021008231511.GA11337@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.573.92.12 -> 1.573.92.13
#	         MAINTAINERS	1.105   -> 1.106  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/07	johannes@erdfelt.com	1.573.92.13
# [PATCH] USB: Trivial MAINTAINERS update
# 
# --------------------------------------------
#
diff -Nru a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	Tue Oct  8 15:53:53 2002
+++ b/MAINTAINERS	Tue Oct  8 15:53:53 2002
@@ -1720,7 +1720,7 @@
 W:	http://www.suse.cz/development/input/
 S:	Maintained
 
-USB HUB
+USB HUB DRIVER
 P:	Johannes Erdfelt
 M:	johannes@erdfelt.com
 L:	linux-usb-users@lists.sourceforge.net
@@ -1863,13 +1863,12 @@
 S:	Supported
 
 USB UHCI DRIVER
-P:	Georg Acher
-M:	usb@in.tum.de
+P:	Johannes Erdfelt
+M:	johannes@erdfelt.com
 L:	linux-usb-users@lists.sourceforge.net
 L:	linux-usb-devel@lists.sourceforge.net
-W:	http://usb.in.tum.de
 S:	Maintained
-	
+
 USB "USBNET" DRIVER
 P:	David Brownell
 M:	dbrownell@users.sourceforge.net
