Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWGLX2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWGLX2o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 19:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWGLX2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 19:28:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:43236 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932197AbWGLX2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 19:28:43 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 1/3] [PATCH] W1: remove w1 mail list from lm_sensors.
Reply-To: Greg KH <greg@kroah.com>
Date: Wed, 12 Jul 2006 16:24:54 -0700
Message-Id: <11527466963731-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <20060712232249.GA22654@kroah.com>
References: <20060712232249.GA22654@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

lm_sensors mail list is going to be splitted into separate subdev lists,
so remove w1 from there.

http://lists.lm-sensors.org/pipermail/lm-sensors/2006-June/016507.html

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 MAINTAINERS |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 645a9f8..491e034 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3180,7 +3180,6 @@ S:	Maintained
 W1 DALLAS'S 1-WIRE BUS
 P:	Evgeniy Polyakov
 M:	johnpol@2ka.mipt.ru
-L:	lm-sensors@lm-sensors.org
 S:	Maintained
 
 W83L51xD SD/MMC CARD INTERFACE DRIVER
-- 
1.4.1

