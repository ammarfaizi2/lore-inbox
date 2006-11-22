Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161829AbWKVIBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161829AbWKVIBf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 03:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161830AbWKVIBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 03:01:34 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:56776 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1161829AbWKVIBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 03:01:34 -0500
Date: Wed, 22 Nov 2006 00:01:06 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: v4l-dvb-maintainer@linuxtv.org, akpm <akpm@osdl.org>
Subject: [PATCH 3/3] kernel-api book: remove videodev chapter
Message-Id: <20061122000106.042af37b.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Remove the videodev chapter from the kernel-api book.
It's done much better in the videobook kernel-doc.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 Documentation/DocBook/kernel-api.tmpl |    5 -----
 1 file changed, 5 deletions(-)

--- linux-2619-rc6g4.orig/Documentation/DocBook/kernel-api.tmpl
+++ linux-2619-rc6g4/Documentation/DocBook/kernel-api.tmpl
@@ -418,11 +418,6 @@ X!Edrivers/pnp/system.c
 !Idrivers/parport/daisy.c
   </chapter>
 
-  <chapter id="viddev">
-     <title>Video4Linux</title>
-!Edrivers/media/video/videodev.c
-  </chapter>
-
   <chapter id="message_devices">
 	<title>Message-based devices</title>
      <sect1><title>Fusion message devices</title>


---
