Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263217AbVGaLS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263217AbVGaLS5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 07:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263070AbVGaLRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 07:17:13 -0400
Received: from coderock.org ([193.77.147.115]:61380 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262902AbVGaLM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 07:12:26 -0400
Message-Id: <20050731111207.863350000@homer>
Date: Sun, 31 Jul 2005 13:12:07 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Tobias Klauser <tklauser@nuerscht.ch>,
       domen@coderock.org
Subject: [patch 2/5] Spelling and whitespace fixes for REPORTING-BUGS
Content-Disposition: inline; filename=spelling-REPORTING-BUGS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tobias Klauser <tklauser@nuerscht.ch>


The attached patch fixes some spelling errors in REPORTING-BUGS and also
removes all trailing whitespaces (I hope this OK with the trivial patch
monkey).

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
Signed-off-by: Domen Puncer <domen@coderock.org>

---
 REPORTING-BUGS |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

Index: quilt/REPORTING-BUGS
===================================================================
--- quilt.orig/REPORTING-BUGS
+++ quilt/REPORTING-BUGS
@@ -9,7 +9,7 @@ screen please read "Documentation/oops-t
 bug report. This explains what you should do with the "Oops" information
 to make it useful to the recipient.
 
-      Send the output the maintainer of the kernel area that seems to
+      Send the output to the maintainer of the kernel area that seems to
 be involved with the problem. Don't worry too much about getting the
 wrong person. If you are unsure send it to the person responsible for the
 code relevant to what you were doing. If it occurs repeatably try and
@@ -18,15 +18,15 @@ The list of maintainers is in the MAINTA
 
       If it is a security bug, please copy the Security Contact listed
 in the MAINTAINERS file.  They can help coordinate bugfix and disclosure.
-See Documentation/SecurityBugs for more infomation.
+See Documentation/SecurityBugs for more information.
 
       If you are totally stumped as to whom to send the report, send it to
 linux-kernel@vger.kernel.org. (For more information on the linux-kernel
 mailing list see http://www.tux.org/lkml/).
 
-This is a suggested format for a bug report sent to the Linux kernel mailing 
-list. Having a standardized bug report form makes it easier  for you not to 
-overlook things, and easier for the developers to find the pieces of 
+This is a suggested format for a bug report sent to the Linux kernel mailing
+list. Having a standardized bug report form makes it easier for you not to
+overlook things, and easier for the developers to find the pieces of
 information they're really interested in. Don't feel you have to follow it.
 
       First run the ver_linux script included as scripts/ver_linux, which
@@ -35,13 +35,13 @@ the command "sh scripts/ver_linux".
 
 Use that information to fill in all fields of the bug report form, and
 post it to the mailing list with a subject of "PROBLEM: <one line
-summary from [1.]>" for easy identification by the developers    
+summary from [1.]>" for easy identification by the developers
 
-[1.] One line summary of the problem:    
+[1.] One line summary of the problem:
 [2.] Full description of the problem/report:
 [3.] Keywords (i.e., modules, networking, kernel):
 [4.] Kernel version (from /proc/version):
-[5.] Output of Oops.. message (if applicable) with symbolic information 
+[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)
 [6.] A small shell script or example program which triggers the
      problem (if possible)

--
