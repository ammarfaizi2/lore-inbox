Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267531AbUG2XxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267531AbUG2XxQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 19:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUG2XxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 19:53:16 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:22943 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267531AbUG2XxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 19:53:13 -0400
Date: Thu, 29 Jul 2004 16:51:52 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: hirofumi@mail.parknet.co.jp, aebr@win.tue.nl, vojtech@suse.cz,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix NR_KEYS off-by-one error
Message-Id: <20040729165152.492faced.pj@sgi.com>
In-Reply-To: <20040729162423.7452e8f5.akpm@osdl.org>
References: <87llhjlxjk.fsf@devron.myhome.or.jp>
	<20040716164435.GA8078@ucw.cz>
	<20040716201523.GC5518@pclin040.win.tue.nl>
	<871xjbkv8g.fsf@devron.myhome.or.jp>
	<20040728115130.GA4008@pclin040.win.tue.nl>
	<87fz7c9j0y.fsf@devron.myhome.or.jp>
	<20040728134202.5938b275.pj@sgi.com>
	<87llh3ihcn.fsf@ibmpc.myhome.or.jp>
	<20040728231548.4edebd5b.pj@sgi.com>
	<87oelzjhcx.fsf@ibmpc.myhome.or.jp>
	<20040729024931.4b4e78e6.pj@sgi.com>
	<20040729162423.7452e8f5.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew:
> ... still waiting ...

Don't wait on me ... as indicated in my last post on this lkml thread,
I left this back in the hands of the expert, OGAWA Hirofumi.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
