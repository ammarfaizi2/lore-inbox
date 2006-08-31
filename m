Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751617AbWHaMSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbWHaMSt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 08:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbWHaMSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 08:18:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25551 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751617AbWHaMSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 08:18:48 -0400
Date: Thu, 31 Aug 2006 14:18:36 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Cc: Paul.Clements@steeleye.com
Subject: network block device is mostly known as "NBD"
Message-ID: <20060831121836.GW3923@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


People search maintainers for NBD and then decide it is not
maintained. 

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bab239..04069bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2015,7 +2015,7 @@ L:	linux-hams@vger.kernel.org
 W:	http://www.linux-ax25.org/
 S:	Maintained
 
-NETWORK BLOCK DEVICE
+NETWORK BLOCK DEVICE (NBD)
 P:	Paul Clements
 M:	Paul.Clements@steeleye.com
 S:	Maintained

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
