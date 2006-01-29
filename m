Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWA2Jtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWA2Jtl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 04:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWA2Jtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 04:49:41 -0500
Received: from tachyon.quantumlinux.com ([64.113.1.99]:3009 "EHLO
	tachyon.quantumlinux.com") by vger.kernel.org with ESMTP
	id S1750820AbWA2Jtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 04:49:40 -0500
Date: Sun, 29 Jan 2006 01:50:16 -0800 (PST)
From: Chuck Wolber <chuckw@quantumlinux.com>
X-X-Sender: chuckw@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: Greg KH <gregkh@suse.de>, stable@kernel.org,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, trivial@rustcorp.com.au
Subject: [PATCH] Documentation/stable_kernel_rules.txt: Clarification
Message-ID: <Pine.LNX.4.63.0601290032110.7252@localhost.localdomain>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This reflects the clarification made on what patches the -stable team 
accepts. This applies cleanly to the 2.6.16-rc1 kernel.

Signed-off-by: Chuck Wolber <chuckw@quantumlinux.com>
---

--- a/Documentation/stable_kernel_rules.txt     2006-01-16 23:44:47.000000000 -0800
+++ b/Documentation/stable_kernel_rules.txt     2006-01-29 01:45:44.000000000 -0800
@@ -18,6 +18,7 @@
    whitespace cleanups, etc).
  - It must be accepted by the relevant subsystem maintainer.
  - It must follow the Documentation/SubmittingPatches rules.
+ - Patches for any 2.6 stable kernel release will be considered.


 Procedure for submitting patches to the -stable tree:
