Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbVJPRyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbVJPRyF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 13:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbVJPRyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 13:54:05 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:59849 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751344AbVJPRyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 13:54:04 -0400
Date: Sun, 16 Oct 2005 10:53:46 -0700
From: Paul Jackson <pj@sgi.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: akpm@osdl.org, jschopp@austin.ibm.com, kravetz@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/8] Fragmentation Avoidance V17
Message-Id: <20051016105346.01c79929.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.58.0510161255570.32005@skynet>
References: <20051011151221.16178.67130.sendpatchset@skynet.csn.ul.ie>
	<20051015195213.44e0dabb.pj@sgi.com>
	<Pine.LNX.4.58.0510161255570.32005@skynet>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel wrote:
> I would be happy with __GFP_USERRCLM but __GFP_EASYRCLM may be more
> obvious?

I would be delighted with either one.  Yes, __GFP_EASYRCLM is more obvious.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
