Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422852AbWJRUQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422852AbWJRUQt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422813AbWJRUQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:16:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:23530 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422812AbWJRUJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:09:16 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 1/16] Documentation: feature-removal-schedule typo
Date: Wed, 18 Oct 2006 13:08:52 -0700
Message-Id: <1161202147758-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <20061018195833.GA21808@kroah.com>
References: <20061018195833.GA21808@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominik Brodowski <linux@dominikbrodowski.net>

Fix typo in newly added feature remove schedule item.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Kay Sievers <kay.sievers@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 Documentation/feature-removal-schedule.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 24f3c63..1ac3c74 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -255,7 +255,7 @@ Who:	Stephen Hemminger <shemminger@osdl.
 
 
 What:	PHYSDEVPATH, PHYSDEVBUS, PHYSDEVDRIVER in the uevent environment
-When:	Oktober 2008
+When:	October 2008
 Why:	The stacking of class devices makes these values misleading and
 	inconsistent.
 	Class devices should not carry any of these properties, and bus
-- 
1.4.2.4

