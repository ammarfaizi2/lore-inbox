Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265632AbTGDByt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 21:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265639AbTGDByt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 21:54:49 -0400
Received: from granite.he.net ([216.218.226.66]:22798 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S265632AbTGDBys convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 21:54:48 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10572845552315@kroah.com>
Subject: Re: [PATCH] PCI and sysfs fixes for 2.5.74
In-Reply-To: <10572845553725@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 3 Jul 2003 19:09:15 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1377, 2003/07/03 17:51:08-07:00, greg@kroah.com

driver core: add my copyright to class.c


 drivers/base/class.c |    2 ++
 1 files changed, 2 insertions(+)


diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	Thu Jul  3 18:15:33 2003
+++ b/drivers/base/class.c	Thu Jul  3 18:15:33 2003
@@ -3,6 +3,8 @@
  *
  * Copyright (c) 2002-3 Patrick Mochel
  * Copyright (c) 2002-3 Open Source Development Labs
+ * Copyright (c) 2003 Greg Kroah-Hartman
+ * Copyright (c) 2003 IBM Corp.
  * 
  * This file is released under the GPLv2
  *

