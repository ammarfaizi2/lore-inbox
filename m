Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272127AbTG2Uwe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 16:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272128AbTG2Uwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 16:52:34 -0400
Received: from tandu.perlsupport.com ([66.220.6.226]:51619 "EHLO
	tandu.perlsupport.com") by vger.kernel.org with ESMTP
	id S272127AbTG2Uwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 16:52:33 -0400
Date: Tue, 29 Jul 2003 13:52:28 -0700
From: Chip Salzenberg <chip@pobox.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, nfs@lists.sourceforge.net
Subject: [PATCH] Require nfs-utils 1.0.5; document where to get it
Message-ID: <20030729205227.GA16486@perlsupport.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The below patch to 2.6 notes that users should get nfs-utils 1.0.5
(1.0.3 had a security bug and 1.0.4 had a memory usage bug), and tells
them where to get it.

--- linux-2.6/Documentation/Changes	2003-07-16 15:54:46.000000000 -0700
+++ linux-2.6/Documentation/Changes.NEW	2003-07-29 13:47:56.000000000 -0700
@@ -64,5 +64,5 @@
 o  procps                 2.0.9                   # ps --version
 o  oprofile               0.5.3                   # oprofiled --version
-o  nfs-utils              1.0.3                   # showmount --version
+o  nfs-utils              1.0.5                   # showmount --version
 
 Kernel compilation
@@ -382,5 +382,10 @@
 --------
 o  <http://oprofile.sf.net/download/>
- 
+
+NFS-Utils
+---------
+o  <http://nfs.sourceforge.net/>
+
+
 Suggestions and corrections
 ===========================



-- 
Chip Salzenberg               - a.k.a. -               <chip@pobox.com>
"I wanted to play hopscotch with the impenetrable mystery of existence,
    but he stepped in a wormhole and had to go in early."  // MST3K
