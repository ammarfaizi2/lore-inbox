Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934528AbWKXJ7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934528AbWKXJ7S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 04:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934534AbWKXJ7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 04:59:18 -0500
Received: from ns1.suse.de ([195.135.220.2]:14789 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S934528AbWKXJ7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 04:59:17 -0500
From: Andi Kleen <ak@suse.de>
To: Mel Gorman <mel@skynet.ie>
Subject: Re: [discuss] 2.6.19-rc6: known regressions (v4)
Date: Fri, 24 Nov 2006 10:58:55 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, Andre Noll <maan@systemlinux.org>,
       discuss@x86-64.org, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Rientjes <rientjes@cs.washington.edu>
References: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org> <20061123110930.abc4fd9a.akpm@osdl.org> <20061123215545.GA9551@skynet.ie>
In-Reply-To: <20061123215545.GA9551@skynet.ie>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611241058.55824.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> A slightly smarter, but not quite as obviously correct, 

I think it's better to go for the "obviously correct" approach right now
And sorting multiple times should be fine

-Andi
