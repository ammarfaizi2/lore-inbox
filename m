Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbVDGBlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbVDGBlV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 21:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbVDGBlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 21:41:21 -0400
Received: from main.gmane.org ([80.91.229.2]:21905 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262370AbVDGBlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 21:41:17 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Martin Pool <mbp@sourcefrog.net>
Subject: Re: Kernel SCM saga..
Date: Thu, 07 Apr 2005 11:40:23 +1000
Message-ID: <pan.2005.04.07.01.40.20.998237@sourcefrog.net>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <20050406193911.GA11659@stingr.stingr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 57.16.168.202.velocitynet.com.au
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Apr 2005 23:39:11 +0400, Paul P Komkoff Jr wrote:

> http://bazaar-ng.org/

I'd like bazaar-ng to be considered too.  It is not ready for adoption
yet, but I am working (more than) full time on it and hope to have it
be usable in a couple of months.  

bazaar-ng is trying to integrate a lot of the work done in other systems
to make something that is simple to use but also fast and powerful enough
to handle large projects.

The operations that are already done are pretty fast: ~60s to import a
kernel tree, ~10s to import a new revision from a patch.  

Please check it out and do pester me with any suggestions about whatever
you think it needs to suit your work.

-- 
Martin


