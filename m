Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbTEVAe2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 20:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbTEVAe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 20:34:27 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:2508 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S262413AbTEVAeZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 20:34:25 -0400
From: Rusty Russell <rusty@au1.ibm.com>
To: dipankar@in.ibm.com
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       David Mosberger-Tang <davidm@hpl.hp.com>,
       Ravikiran G Thirumalai <kiran@in.ibm.com>
Subject: Re: [PATCH 4/3] Replace dynamic percpu implementation 
In-reply-to: Your message of "Wed, 21 May 2003 16:01:56 +0530."
             <20030521103156.GB2861@in.ibm.com> 
Date: Thu, 22 May 2003 10:35:51 +1000
Message-Id: <20030522004716.2B69817DE5@ozlabs.au.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030521103156.GB2861@in.ibm.com> you write:
> Considering these results, this allocator seems to be a step in the right
> direction.

I had a great chat with David M-T: I'm backing off this until we have
a IA64 code which keeps its current advantages.

If you can find someone to work on the IA64 specific stuff, I think
everyone will be happy.

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
