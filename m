Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbWFZA6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbWFZA6M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 20:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbWFZA6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 20:58:12 -0400
Received: from terminus.zytor.com ([192.83.249.54]:6031 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964968AbWFZA6L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:58:11 -0400
Date: Sun, 25 Jun 2006 17:57:58 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: [klibc 01/43] Add klibc/kinit to MAINTAINERS file
Message-Id: <klibc.200606251757.01@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 646e16312efb438f6e1ea58bdb1d9afad9477933
tree f37d1fc67f9f1ef49d81dfbb39b9a621ed246073
parent 427abfa28afedffadfca9dd8b067eb6d36bac53f
author H. Peter Anvin <hpa@zytor.com> Sat, 25 Mar 2006 16:36:59 -0800
committer H. Peter Anvin <hpa@zytor.com> Sun, 18 Jun 2006 18:43:53 -0700

 MAINTAINERS |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c3c5842..e95d825 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1616,6 +1616,13 @@ L:	linux-kernel@vger.kernel.org
 L:	fastboot@osdl.org
 S:	Maintained
 
+KLIBC/KINIT
+P:	H. Peter Anvin
+M:	hpa@zytor.com
+L:	klibc@zytor.com
+T:	git kernel.org:pub/scm/linux/kernel/git/hpa/linux-2.6-klibc.git
+S:	Maintained
+
 KPROBES
 P:	Prasanna S Panchamukhi
 M:	prasanna@in.ibm.com
