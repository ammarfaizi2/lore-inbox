Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262144AbVBJPnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbVBJPnW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 10:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbVBJPnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 10:43:22 -0500
Received: from sd291.sivit.org ([194.146.225.122]:55497 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262144AbVBJPmm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 10:42:42 -0500
Date: Thu, 10 Feb 2005 16:44:21 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 0/5] sonypi driver update
Message-ID: <20050210154420.GE3493@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Over the last few weeks I've collected a few patches in my tree
coming from others and it's time to merge them upstream:

	1/5: sonypi: replace schedule_timeout() with msleep()
	2/5: sonypi: add another HELP button event
	3/5: sonypi: use MISC_DYNAMIC_MINOR in miscdevice.minor assignment.
	4/5: sonypi: fold the contents of sonypi.h into sonypi.c
	5/5: sonypi: add fan and temperature status/control

Please apply.

Thanks.

Stelian.
-- 
Stelian Pop <stelian@popies.net>
