Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbUJYBVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbUJYBVG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 21:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbUJYBVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 21:21:06 -0400
Received: from main.gmane.org ([80.91.229.2]:64709 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261648AbUJYBVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 21:21:03 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: Serious stability issues with 2.6.10-rc1
Date: Sun, 24 Oct 2004 18:20:55 -0700
Message-ID: <pan.2004.10.25.01.20.55.763270@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-126-181-112.dsl.pltn13.pacbell.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

2.6.10-rc1 seems to have a tendency to lock up after about 8 hours or so
of uptime. Usually, I am in X, listening to music, and working on
something when this happens out of the blue. It's a hard hang and there is
no network response or ability to switch back to a tty so i can get
sysrq-t output. It just dies. This has happened twice in the past 48 or
so hours.

I can't really provide much debugging info though, due to the nature of
the hang. Is there anything that pops into mind that I should try to nail
this problem?

2.6.9 seems to be a lot better at staying alive.

Thanks

-- 
Joshua Kwan


