Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751455AbWF1QzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbWF1QzW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 12:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWF1QzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:55:21 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44036 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751455AbWF1QzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:55:19 -0400
Date: Wed, 28 Jun 2006 18:55:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] typo fixes in Documentation/networking/pktgen.txt
Message-ID: <20060628165518.GD13915@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Three typos in only one line...

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm3-full/Documentation/networking/pktgen.txt.old	2006-06-27 20:50:47.000000000 +0200
+++ linux-2.6.17-mm3-full/Documentation/networking/pktgen.txt	2006-06-27 20:51:09.000000000 +0200
@@ -74,7 +74,7 @@
  pgset "pkt_size 9014"   sets packet size to 9014
  pgset "frags 5"         packet will consist of 5 fragments
  pgset "count 200000"    sets number of packets to send, set to zero
-                         for continious sends untill explicitl stopped.
+                         for continuous sends until explicitly stopped.
 
  pgset "delay 5000"      adds delay to hard_start_xmit(). nanoseconds
 

