Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263655AbTJCJUA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 05:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbTJCJUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 05:20:00 -0400
Received: from dyn-ctb-203-221-73-69.webone.com.au ([203.221.73.69]:3852 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S263655AbTJCJTy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 05:19:54 -0400
Message-ID: <3F7D3F37.1060005@cyberone.com.au>
Date: Fri, 03 Oct 2003 19:19:51 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>
Subject: must-fix list reconciliation
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,
As you might or might not know, the must-fix / should-fix lists have been
inadvertently forked. We are merging them again, so please don't update
the wiki until we have worked out what to do with them. This should be a
day or two at most.

I had the idea that maybe we could put them into the source tree, and
encourage people to keep them up to date by making them become criteria
for the feature and code freeze. Comments?

Thanks,
Nick

