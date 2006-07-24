Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWGXWGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWGXWGB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 18:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWGXWGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 18:06:01 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:11713 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932272AbWGXWGA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 18:06:00 -0400
Subject: [PATCH] [efs] Add entry for EFS filesystem to MAINTAINERS as Orphan
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 24 Jul 2006 15:06:01 -0700
Message-Id: <1153778761.31581.0.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The EFS filesystem does not have an entry in MAINTAINERS; add one, giving the
EFS filesystem and listing the status as Orphan, per the note on that page
saying "I'm no longer actively maintaining EFS".

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 MAINTAINERS |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b2afc7a..126a4df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -968,6 +968,10 @@ P:	Andrey V. Savochkin
 M:	saw@saw.sw.com.sg
 S:	Maintained
 
+EFS FILESYSTEM
+W:	http://aeschi.ch.eu.org/efs/
+S:	Orphan
+
 EMU10K1 SOUND DRIVER
 P:	James Courtier-Dutton
 M:	James@superbug.demon.co.uk


