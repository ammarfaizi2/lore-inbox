Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWGXQ0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWGXQ0Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 12:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWGXQ0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 12:26:16 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:39652 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751345AbWGXQ0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 12:26:15 -0400
Subject: [PATCH V2] Add linux-mm mailing list for memory management in
	MAINTAINERS file
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       linux-mm@kvack.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Dave Jones <davej@redhat.com>, Jesper Juhl <jesper.juhl@gmail.com>
In-Reply-To: <20060724160749.GC27806@redhat.com>
References: <1153713707.4002.43.camel@localhost.localdomain>
	 <1153749795.23798.19.camel@lappy>
	 <1153751558.4002.112.camel@localhost.localdomain>
	 <20060724160749.GC27806@redhat.com>
Content-Type: text/plain
Date: Mon, 24 Jul 2006 12:25:53 -0400
Message-Id: <1153758353.11295.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Version 2 - with input from Dave Jones and Jesper Juhl]

Since I didn't know about the linux-mm mailing list until I spammed all
those that had their names anywhere in the mm directory, I'm sending
this patch to add the linux-mm mailing list to the MAINTAINERS file.

Also, since mm is so broad, it doesn't have a single person to maintain
it, and thus no maintainer is listed.  I also left the status as
Maintained, since it obviously is.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.18-rc2/MAINTAINERS
===================================================================
--- linux-2.6.18-rc2.orig/MAINTAINERS	2006-07-23 23:32:13.000000000 -0400
+++ linux-2.6.18-rc2/MAINTAINERS	2006-07-24 12:23:53.000000000 -0400
@@ -1884,6 +1884,12 @@ S:     linux-scsi@vger.kernel.org
 W:     http://megaraid.lsilogic.com
 S:     Maintained
 
+MEMORY MANAGEMENT
+L:	linux-mm@kvack.org
+L:	linux-kernel@vger.kernel.org
+W:	http://www.linux-mm.org
+S:	Maintained
+
 MEMORY TECHNOLOGY DEVICES (MTD)
 P:	David Woodhouse
 M:	dwmw2@infradead.org


