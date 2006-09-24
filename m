Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbWIXWjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWIXWjc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 18:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWIXWjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 18:39:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60895 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751450AbWIXWjb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 18:39:31 -0400
Date: Sun, 24 Sep 2006 23:39:25 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Subject: [PATCH] restore libata build on frv
Message-ID: <20060924223925.GU29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/asm-frv/libata-portmap.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/asm-frv/libata-portmap.h b/include/asm-frv/libata-portmap.h
new file mode 100644
index 0000000..75484ef
--- /dev/null
+++ b/include/asm-frv/libata-portmap.h
@@ -0,0 +1 @@
+#include <asm-generic/libata-portmap.h>
-- 
1.4.2.GIT
