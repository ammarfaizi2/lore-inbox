Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbUCFQUF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 11:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUCFQUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 11:20:05 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:55017 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261684AbUCFQUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 11:20:02 -0500
To: linux-kernel@vger.kernel.org
From: Karl Dahlke <eklhad@comcast.net>
Reply-to: Karl Dahlke <eklhad@comcast.net>
Subject: dhclient, 2.6.0, config_filter
Date: Sat, 06 Mar 2004 11:21:54
Mime-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <S261684AbUCFQUC/20040306162003Z+795@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps this has been asked many times here; I don't usually read this list,
but I can't find an answer anywhere else.

I upgraded to kernel 2.6.0, then 2.6.3,
and dhclient won't work, because I didn't say yes to CONFIG_FILTER.
But aha, CONFIG_FILTER is gone.  Nowhere to be found.
The config options before and after this one are still there,
but CONFIG_FILTER is not in Kconfig at all.
What should I do?
