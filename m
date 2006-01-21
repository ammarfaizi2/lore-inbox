Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWAUVew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWAUVew (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 16:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWAUVew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 16:34:52 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:6030 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S932367AbWAUVew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 16:34:52 -0500
To: philb@gnu.org, tim@cyberelk.net, campbell@torque.net, andrea@suse.de
Cc: linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org,
       trivial@kernel.org
Subject: [PATCH] parport: remove dead address in MAINTAINERS
From: Arnaud Giersch <arnaud.giersch@free.fr>
Date: Sat, 21 Jan 2006 22:34:50 +0100
Message-ID: <87irsde03p.fsf@groumpf.homeip.net>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaud Giersch <arnaud.giersch@free.fr>

Remove dead address for David Campbell in MAINTAINERS.

Signed-off-by: Arnaud Giersch <arnaud.giersch@free.fr>
---

  I got the following error message for all mails sent to
  <campbell@torque.net> since January 9, 2006:
 
  <campbell@torque.net>: host torque.net.inbound10.mxlogic.net[216.183.119.118]
    said: 550 <campbell@torque.net>: User unknown in virtual alias table (in
    reply to RCPT TO command)

--- linux-2.6.16-rc1.orig/MAINTAINERS	2006-01-17 08:44:47.000000000 +0100
+++ linux-2.6.16-rc1/MAINTAINERS	2006-01-21 21:39:08.503248571 +0100
@@ -1966,7 +1966,6 @@ M:	philb@gnu.org
 P:	Tim Waugh
 M:	tim@cyberelk.net
 P:	David Campbell
-M:	campbell@torque.net
 P:	Andrea Arcangeli
 M:	andrea@suse.de
 L:	linux-parport@lists.infradead.org
