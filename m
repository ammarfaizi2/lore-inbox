Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbUJ3SqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbUJ3SqK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 14:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbUJ3SqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 14:46:09 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:29595 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261226AbUJ3SqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 14:46:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=DAKpgoVIXngCBbHlM2lzt8FjfxfJUi/IACOiYcth4kLETu3mNrrlHx0esJZpe1XB5tJNu9bT0ysitZRzM/HroeW9ylR6mlYnbRo1XZNP4XQ8GHfQPFX7PTf5e3mqQSeFS/JubcQOOS4VO5zH8p3ZxJZyZiLvvPhe32Yd3sPbMHI=
Message-ID: <5d1794bb04103011465b4efd52@mail.gmail.com>
Date: Sat, 30 Oct 2004 22:46:08 +0400
From: Vasya Pupkin <ptushnik@gmail.com>
Reply-To: Vasya Pupkin <ptushnik@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] comment typo
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vasia Pupkin <ptushnik@gmail.com>

--- linux-2.6.9/kernel/timer.c.orig     2004-10-30 22:41:14.000000000 +0400
+++ linux-2.6.9/kernel/timer.c  2004-10-30 22:41:52.000000000 +0400
@@ -654,7 +654,7 @@
 /* 
  * The current time 
  * wall_to_monotonic is what we need to add to xtime (or xtime corrected 
- * for sub jiffie times) to get to monotonic time.  Monotonic is pegged at zero
+ * for sub jiffie times) to get to monotonic time.  Monotonic is pegged
  * at zero at system boot time, so wall_to_monotonic will be negative,
  * however, we will ALWAYS keep the tv_nsec part positive so we can use
  * the usual normalization.
