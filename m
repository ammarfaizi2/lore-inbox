Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317908AbSGWAjC>; Mon, 22 Jul 2002 20:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317892AbSGWAh7>; Mon, 22 Jul 2002 20:37:59 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:9988 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317895AbSGWAgv>;
	Mon, 22 Jul 2002 20:36:51 -0400
Date: Mon, 22 Jul 2002 17:40:07 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [BK PATCH] LSM changes for 2.5.27
Message-ID: <20020723004007.GF660@kroah.com>
References: <20020723003702.GA660@kroah.com> <20020723003806.GB660@kroah.com> <20020723003905.GC660@kroah.com> <20020723003935.GD660@kroah.com> <20020723003952.GE660@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020723003952.GE660@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 24 Jun 2002 23:35:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.683.1.3 -> 1.683.1.4
#	             CREDITS	1.55    -> 1.56   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/22	greg@kroah.com	1.683.1.4
# updated my CREDITS entry.
# --------------------------------------------
#
diff -Nru a/CREDITS b/CREDITS
--- a/CREDITS	Mon Jul 22 17:25:59 2002
+++ b/CREDITS	Mon Jul 22 17:25:59 2002
@@ -1670,6 +1670,7 @@
 D: USB Bluetooth driver, USB Skeleton driver
 D: bits and pieces of USB core code.
 D: PCI Hotplug core, PCI Hotplug Compaq driver modifications
+D: portions of the Linux Security Module (LSM) framework
 
 N: Russell Kroll
 E: rkroll@exploits.org
