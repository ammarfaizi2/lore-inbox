Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbUBDXDq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 18:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266628AbUBDXDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 18:03:46 -0500
Received: from gprs148-146.eurotel.cz ([160.218.148.146]:2945 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264363AbUBDXDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 18:03:14 -0500
Date: Thu, 5 Feb 2004 00:01:33 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: kgdb support in vanilla 2.6.2
Message-ID: <20040204230133.GA8702@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

It seems that some kgdb support is in 2.6.2-linus:

+++ b/Documentation/sh/kgdb.txt Tue Feb  3 19:45:43 2004
@@ -0,0 +1,179 @@
+
+This file describes the configuration and behavior of KGDB for the SH
+kernel. Based on a description from Henry Bell <henry.bell@st.com>, it
+has been modified to account for quirks in the current implementation.
+

That's great, can we get i386 kgdb, too? Or at least amd64 kgdb
;-). [Or was it a mistake? It seems unlikely that kgdb could enter
Linus tree without major flamewar...]

								Pavel 
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
