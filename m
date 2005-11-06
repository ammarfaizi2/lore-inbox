Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbVKFGzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbVKFGzh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 01:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbVKFGzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 01:55:37 -0500
Received: from dial169-190.awalnet.net ([213.184.169.190]:21004 "EHLO
	raad.intranet") by vger.kernel.org with ESMTP id S1751163AbVKFGzg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 01:55:36 -0500
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.14 bug check
Date: Sun, 6 Nov 2005 09:51:38 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511060951.38753.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. erratic blockdev access
2.  /proc/sys/vm/overcommit_memory = 2 not honored
3. DRM_i810 hangs during suspend-to-ram cycle

Thanks!

--
Al

