Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266495AbUFUWak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266495AbUFUWak (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 18:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266492AbUFUWah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 18:30:37 -0400
Received: from main.gmane.org ([80.91.224.249]:5288 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266494AbUFUWab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 18:30:31 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <jkwan@rackable.com>
Subject: What happened to linux/802_11.h?
Date: Mon, 21 Jun 2004 15:26:57 -0700
Message-ID: <pan.2004.06.21.22.25.18.591967@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 64-60-248-66.cust.telepacific.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian	GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

linus.patch from -mm1:
# BitKeeper/deleted/.del-802_11.h~9b6bd4cff8af7a90
#   2004/06/18 09:47:58-07:00 torvalds@ppc970.osdl.org +0 -0
#   Delete: include/linux/802_11.h

Why was this file removed? The IPW2100 driver
(http://ipw2100.sourceforge.net) uses its definitions and now won't build
against -bk or -mm kernel source.

-- 
Joshua Kwan


