Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267890AbUJDJki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267890AbUJDJki (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 05:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267901AbUJDJki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 05:40:38 -0400
Received: from spc1-leed3-6-0-cust18.seac.broadband.ntl.com ([80.7.68.18]:31229
	"EHLO fentible.pjc.net") by vger.kernel.org with ESMTP
	id S267890AbUJDJkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 05:40:15 -0400
Date: Mon, 4 Oct 2004 10:40:13 +0100
From: Patrick Caulfield <patrick@tykepenguin.com>
To: linux-kernel@vger.kernel.org
Cc: davem@redhat.com, Steve Whitehouse <Steve@ChyGwyn.com>
Subject: [PATCH] [2.6] DECnet maintainer
Message-ID: <20041004094013.GB5855@tykepenguin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Whitehouse has handed over the DECnet maintainership to me. Here's a
patch for the MAINTAINERS file for 2.6.

patrick

===== MAINTAINERS 1.240 vs edited =====
--- 1.240/MAINTAINERS	2004-09-22 21:35:24 +01:00
+++ edited/MAINTAINERS	2004-10-04 10:01:13 +01:00
@@ -632,9 +632,9 @@
 S:	Maintained
 
 DECnet NETWORK LAYER
-P:	Steven Whitehouse
-M:	SteveW@ACM.org
-W:	http://www.sucs.swan.ac.uk/~rohan/DECnet/index.html
+P:	Patrick Caulfield
+M:	patrick@tykepenguin.com
+W:	http://linux-decnet.sourceforge.net
 L:	linux-decnet-user@lists.sourceforge.net
 S:	Maintained
 
