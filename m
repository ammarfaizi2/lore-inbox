Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317880AbSGWAgo>; Mon, 22 Jul 2002 20:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317881AbSGWAgn>; Mon, 22 Jul 2002 20:36:43 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:9220 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317880AbSGWAgh>;
	Mon, 22 Jul 2002 20:36:37 -0400
Date: Mon, 22 Jul 2002 17:39:52 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [BK PATCH] LSM changes for 2.5.27
Message-ID: <20020723003952.GE660@kroah.com>
References: <20020723003702.GA660@kroah.com> <20020723003806.GB660@kroah.com> <20020723003905.GC660@kroah.com> <20020723003935.GD660@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020723003935.GD660@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 24 Jun 2002 23:35:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.683.1.2 -> 1.683.1.3
#	             CREDITS	1.54    -> 1.55   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/22	sds@tislabs.com	1.683.1.3
# [PATCH] LSM: CREDITS entries
# 
# Here are CREDITS entries for myself and my two colleagues who also
# contributed to LSM.
# --------------------------------------------
#
diff -Nru a/CREDITS b/CREDITS
--- a/CREDITS	Mon Jul 22 17:26:01 2002
+++ b/CREDITS	Mon Jul 22 17:26:01 2002
@@ -2649,6 +2649,11 @@
 S: 8006 Zuerich
 S: Switzerland
 
+N: Wayne Salamon
+E: wsalamon@tislabs.com
+E: wsalamon@nai.com
+D: portions of the Linux Security Module (LSM) framework and security modules
+
 N: Robert Sanders
 E: gt8134b@prism.gatech.edu
 D: Dosemu
@@ -2775,6 +2780,11 @@
 S: Minto, NSW, 2566
 S: Australia
 
+N: Stephen Smalley
+E: sds@tislabs.com
+E: ssmalley@nai.com
+D: portions of the Linux Security Module (LSM) framework and security modules
+
 N: Chris Smith
 E: csmith@convex.com
 D: Read only HPFS filesystem
@@ -3040,6 +3050,11 @@
 S: C. Huysmansstraat 12
 S: B-3128 Baal
 S: Belgium
+
+N: Chris Vance
+E: cvance@tislabs.com
+E: cvance@nai.com
+D: portions of the Linux Security Module (LSM) framework and security modules
 
 N: Petr Vandrovec
 E: vandrove@vc.cvut.cz
