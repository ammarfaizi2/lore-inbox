Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWGAKya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWGAKya (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 06:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWGAKyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 06:54:05 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:2029 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750938AbWGAKyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 06:54:00 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 2 of 2] Add a MAINTAINERS entry for Calgary
X-Mercurial-Node: fb5f1c67954816b63e542ea4d80f5a2b294ca10c
Message-Id: <fb5f1c67954816b63e54.1151751238@rhun.haifa.ibm.com>
In-Reply-To: <patchbomb.1151751236@rhun.haifa.ibm.com>
Date: Sat,  1 Jul 2006 13:53:58 +0300
From: muli@il.ibm.com
To: ak@suse.de
Cc: muli@il.ibm.com, jdmason@us.ibm.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# HG changeset patch
# User Muli Ben-Yehuda <muli@il.ibm.com>
# Node ID fb5f1c67954816b63e542ea4d80f5a2b294ca10c
# Parent  c4bd0cdcce626b9edc0b4fa3e94c8d9666cf977a
Add a MAINTAINERS entry for Calgary

Signed-Off-By: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-Off-By: Jon Mason <jdmason@us.ibm.com>

diff -r c4bd0cdcce62 -r fb5f1c679548 MAINTAINERS
--- a/MAINTAINERS	Sat Jul 01 13:39:52 2006 +0300
+++ b/MAINTAINERS	Sat Jul 01 13:40:56 2006 +0300
@@ -606,6 +606,15 @@ L:	video4linux-list@redhat.com
 L:	video4linux-list@redhat.com
 W:	http://linuxtv.org
 T:	git kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git
+S:	Maintained
+
+CALGARY x86-64 IOMMU
+P:	Muli Ben-Yehuda
+M:	muli@il.ibm.com
+P:	Jon D. Mason
+M:	jdmason@us.ibm.com
+L:	linux-kernel@vger.kernel.org
+L:	discuss@x86-64.org
 S:	Maintained
 
 COMMON INTERNET FILE SYSTEM (CIFS)
