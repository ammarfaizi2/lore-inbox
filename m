Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbUL0At3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbUL0At3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 19:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbUL0At2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 19:49:28 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:41114 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261562AbUL0AtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 19:49:04 -0500
Subject: PATCH: 2.6.10 - CREDITS
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104104707.16487.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 26 Dec 2004 23:45:08 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Laufer informed the list that he had changed address and his change
of address had been ignored so CREDITS was still wrong although other
files had been updated.

Fix this.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.10/CREDITS linux-2.6.10/CREDITS
--- linux.vanilla-2.6.10/CREDITS	2004-12-25 21:15:31.000000000 +0000
+++ linux-2.6.10/CREDITS	2004-12-26 17:29:07.731377688 +0000
@@ -1893,7 +1893,7 @@
 D: Bug fixes
 
 N: Paul Laufer
-E: pelaufer@csupomona.edu
+E: paul@laufernet.com
 D: Soundblaster driver fixes, ISAPnP quirk
 S: California, USA
 

