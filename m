Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVFVObP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVFVObP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 10:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVFVObO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 10:31:14 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:47848 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261316AbVFVO2J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 10:28:09 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17081.30073.460287.441567@tut.ibm.com>
Date: Wed, 22 Jun 2005 09:28:09 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12-mm1] relayfs: add relayfs website to documentation
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

relayfs now has an 'official' website and mailing list at

	http://relayfs.sourceforge.net

This patch adds a link to the website to relayfs.txt.


Tom

Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>

diff -urpN -X dontdiff linux-2.6.12-mm1/Documentation/filesystems/relayfs.txt linux-2.6.12-mm1-cur/Documentation/filesystems/relayfs.txt
--- linux-2.6.12-mm1/Documentation/filesystems/relayfs.txt	2005-06-22 11:16:21.000000000 -0500
+++ linux-2.6.12-mm1-cur/Documentation/filesystems/relayfs.txt	2005-06-22 11:53:51.000000000 -0500
@@ -190,6 +190,14 @@ within the kernel application, such as e
 the channel.
 
 
+Resources
+=========
+
+For news, example code, mailing list, etc. see the relayfs homepage:
+
+    http://relayfs.sourceforge.net
+
+
 Credits
 =======
 



