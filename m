Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267301AbUJBQR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267301AbUJBQR3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 12:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267313AbUJBQR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 12:17:29 -0400
Received: from verein.lst.de ([213.95.11.210]:932 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S267301AbUJBQLw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 12:11:52 -0400
Date: Sat, 2 Oct 2004 18:11:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org, takata@linux-m32r.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove arch/m32r/drivers/cs_internal.h
Message-ID: <20041002161145.GA18913@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

completely unused wrapper


--- 1.1/arch/m32r/drivers/cs_internal.h	2004-09-17 09:06:56 +02:00
+++ edited/arch/m32r/drivers/cs_internal.h	2004-10-02 18:13:58 +02:00
@@ -1,2 +0,0 @@
-#include "../../../drivers/pcmcia/cs_internal.h"
-
