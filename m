Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTFJSRQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbTFJSRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:17:15 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:41479 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261960AbTFJSQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:16:27 -0400
Date: Tue, 10 Jun 2003 19:29:58 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Dipankar Sarma <dipankar@in.ibm.com>
cc: Thomas Winischhofer <thomas@winischhofer.net>,
       Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Misc 2.5 Fixes: cp-user-sisfb
In-Reply-To: <20030610173457.GB1443@in.ibm.com>
Message-ID: <Pine.LNX.4.44.0306101926180.32228-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Thanks, but this was already fixed in my latest version. I really should 
> > commit more often...
> 
> Since 2.5 is getting close to 2.6, *now* would be a good time .... 

I have several fixes and patches. Unfortunely they don't get much testing 
outside a few people. I think the best plan at this point is to apply the 
newest code to the -mm tree for testing and after several weeks try to 
push it to linus. The framebuffer stuff will always take time to sync 
mainline because if its wrong your system is borked. Its better to make 
sure its working ~100% before commiting.
 

