Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbUKHQgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbUKHQgP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 11:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbUKHQgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 11:36:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11970 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261846AbUKHOe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:34:29 -0500
Date: Mon, 8 Nov 2004 14:34:16 GMT
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH 1/20] FRV: Fujitsu FR-V CPU arch maintainer record
Message-ID: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch supplies the maintainer record for an architecture
implementation for the Fujistu FR-V CPU series.

Signed-Off-By: dhowells@redhat.com
---
diffstat frv-maintainer-2610rc1mm3.diff
 MAINTAINERS |    5 +++++
 1 files changed, 5 insertions(+)

diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/MAINTAINERS linux-2.6.10-rc1-mm3-frv/MAINTAINERS
--- /warthog/kernels/linux-2.6.10-rc1-mm3/MAINTAINERS	2004-11-05 13:15:52.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/MAINTAINERS	2004-11-05 14:13:04.000000000 +0000
@@ -856,6 +856,11 @@ M:	hch@infradead.org
 W:	ftp://ftp.openlinux.org/pub/people/hch/vxfs
 S:	Maintained
 
+FUJITSU FR-V PORT
+P:	David Howells
+M:	dhowells@redhat.com
+S:	Maintained
+
 FTAPE/QIC-117
 L:	linux-tape@vger.kernel.org
 W:	http://sourceforge.net/projects/ftape
