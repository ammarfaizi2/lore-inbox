Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317312AbSGNVH4>; Sun, 14 Jul 2002 17:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317309AbSGNVHy>; Sun, 14 Jul 2002 17:07:54 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:27124 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317312AbSGNVHt>; Sun, 14 Jul 2002 17:07:49 -0400
Subject: [PATCH] preemptive kernel for 2.4.19-rc1-ac3
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: kpreempt-tech@lists.sourceforge.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 14 Jul 2002 14:10:42 -0700
Message-Id: <1026681042.939.9.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A preempt-kernel patch for 2.4.19-rc1-ac3 is available at:

	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/preempt-kernel-rml-2.4.19-rc1-ac3-1.patch

and mirrors.

The recent scheduler bits introduced plenty of changes to cause the
patch to fail to apply.

This new preempt-kernel patch also includes some of the
scheduler-related preemption optimizations found in 2.5.

	Robert Love

