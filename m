Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268479AbUILFnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268479AbUILFnX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 01:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268463AbUILFnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 01:43:23 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:20418 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268479AbUILFnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 01:43:21 -0400
Date: Sat, 11 Sep 2004 22:42:01 -0700
From: Paul Jackson <pj@sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: anton@samba.org, akpm@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, ak@suse.de, iwamoto@valinux.co.jp
Subject: Re: [Patch 4/4] cpusets top mask just online, not all possible
Message-Id: <20040911224201.7b085629.pj@sgi.com>
In-Reply-To: <1094964209.16406.22.camel@localhost>
References: <20040911082810.10372.86008.84920@sam.engr.sgi.com>
	<20040911082834.10372.51697.75658@sam.engr.sgi.com>
	<20040911141001.GD32755@krispykreme>
	<20040911100731.2f400271.pj@sgi.com>
	<1094923728.3997.10.camel@localhost>
	<20040911192156.1da7c636.pj@sgi.com>
	<1094964209.16406.22.camel@localhost>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pj wrote:
>   I expect that disabling a Memory Node should result in some
>   "move_task_off_dead_memory()" routine, ...
>   Does this expectation fit for you?

Dave replied:
> That seems pretty reasonable to me.  ...

In other words, as is apparent in the reply I just sent a few minutes
ago, what I wrote about "move_task_off_dead_memory()" routine no longer
seems at all reasonable to me ;).

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
