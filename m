Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422636AbVLXIHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422636AbVLXIHY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 03:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422637AbVLXIHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 03:07:24 -0500
Received: from mailspool.ops.uunet.co.za ([196.7.0.140]:63237 "EHLO
	mailspool.ops.uunet.co.za") by vger.kernel.org with ESMTP
	id S1422636AbVLXIHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 03:07:24 -0500
From: "Jaco Kroon" <jkroon@kroon.co.za>
Date: Sat, 24 Dec 2005 10:08:46 +0200
To: acpi-devel@lists.sourceforge.net
Subject: Add Toshiba Satellite P10-792 to Doc*/power/video.txt
Cc: linux-kernel@vger.kernel.org
Reply-To: jaco@kroon.co.za
Message-Id: <20051224080203.3FFF587146@belrog.fns.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the Toshiba Satellite P10-792 to the list of systems where video can be made to work during suspend-to-ram.

Signed-of-by: Jaco Kroon <jaco@kroon.co.za>

--- linux/Documentation/power/video.txt.orig	2005-12-24 09:57:04.000000000 +0200
+++ linux/Documentation/power/video.txt	2005-12-24 09:57:15.000000000 +0200
@@ -134,6 +134,7 @@
 Toshiba Satellite 4080XCDT      s3_mode (3)
 Toshiba Satellite 4090XCDT      ??? (*)
 Toshiba Satellite P10-554       s3_bios,s3_mode (4)(****)
+Toshiba Satellite P10-792       s3_bios,s3_mode (4)(****)
 Toshiba M30                     (2) xor X with nvidia driver using internal AGP
 Uniwill 244IIO			??? (*)
 
