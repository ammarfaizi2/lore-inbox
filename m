Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423149AbWF1FSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423149AbWF1FSD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423151AbWF1FSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:18:03 -0400
Received: from terminus.zytor.com ([192.83.249.54]:30441 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1423149AbWF1FSC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:18:02 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Subject: [klibc 01/31] Add klibc/kinit to MAINTAINERS file
Date: Tue, 27 Jun 2006 22:17:01 -0700
Message-Id: <klibc.200606272217.01@tazenda.hos.anvin.org>
In-Reply-To: <klibc.200606272217.00@tazenda.hos.anvin.org>
References: <klibc.200606272217.00@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 9371ae0abc260d3f87f243b364e86d837a3a23fd
tree 25d49641dc6ff9858056a5a19485602073a11166
parent d38b69689c349f35502b92e20dafb30c62d49d63
author H. Peter Anvin <hpa@zytor.com> Sat, 25 Mar 2006 16:36:59 -0800
committer H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:50:19 -0700

 MAINTAINERS |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 31a1372..393a7cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1651,6 +1651,13 @@ L:	linux-kernel@vger.kernel.org
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
