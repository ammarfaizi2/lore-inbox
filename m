Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269267AbUIBXhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269267AbUIBXhP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 19:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269311AbUIBXft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 19:35:49 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:2569 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S269289AbUIBXdS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 19:33:18 -0400
Subject: vfat problems in 2.6.8.1-mm2+
From: Kasper Sandberg <lkml@metanurb.dk>
To: LKML Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 03 Sep 2004 01:33:17 +0200
Message-Id: <1094167997.11821.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey, i recently discovered that my kernel completely crashed when
accessing my vfat partitions under 2.6.8.1-mm2+, somtimes it worked, and
then suddenly it will just freeze, and i have to hard reset.. its quite
strange, the files worked, but it would some time crash...
when booting windows, it scandisked, and said it converted dirs to
files, and then there were just 32kb files instead of a dir with 7gb..

any idea why this happens?
-- 
Kasper Sandberg <lkml@metanurb.dk>

