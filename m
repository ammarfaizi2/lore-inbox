Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317901AbSGWAjD>; Mon, 22 Jul 2002 20:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317907AbSGWAhw>; Mon, 22 Jul 2002 20:37:52 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:11268 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317901AbSGWAhf>;
	Mon, 22 Jul 2002 20:37:35 -0400
Date: Mon, 22 Jul 2002 17:40:51 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [BK PATCH] LSM changes for 2.5.27
Message-ID: <20020723004051.GH660@kroah.com>
References: <20020723003702.GA660@kroah.com> <20020723003806.GB660@kroah.com> <20020723003905.GC660@kroah.com> <20020723003935.GD660@kroah.com> <20020723003952.GE660@kroah.com> <20020723004007.GF660@kroah.com> <20020723004034.GG660@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020723004034.GG660@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 24 Jun 2002 23:35:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.683.1.5 -> 1.683.1.6
#	             CREDITS	1.56    -> 1.57   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/22	chris@wirex.com	1.683.1.6
# [PATCH] LSM: CREDITS entry
# 
# --------------------------------------------
#
diff -Nru a/CREDITS b/CREDITS
--- a/CREDITS	Mon Jul 22 17:25:54 2002
+++ b/CREDITS	Mon Jul 22 17:25:54 2002
@@ -3289,6 +3289,14 @@
 S: Cambridge. CB1 7EG
 S: England
 
+N: Chris Wright
+E: chris@wirex.com
+D: hacking on LSM framework and security modules.
+S: c/o WireX
+S: 920 SW 3rd, Ste. 100
+S: Portland, OR 97204
+S: USA
+
 N: Frank Xia
 E: qx@math.columbia.edu
 D: Xiafs filesystem [defunct]
