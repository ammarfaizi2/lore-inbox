Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263030AbVGIAqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263030AbVGIAqm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 20:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263029AbVGIAoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:44:07 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:47801 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S263030AbVGIAnZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:43:25 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: Ed Cogburn <edcogburn@hotpop.com>, linux-kernel@vger.kernel.org
X-X-Sender: dlang@dlang.diginsite.com
Date: Fri, 8 Jul 2005 17:39:25 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: reiser4 vs politics: linux misses out again
In-Reply-To: <200507082026.49404.tomlins@cam.org>
Message-ID: <Pine.LNX.4.62.0507081737120.4458@qynat.qvtvafvgr.pbz>
References: <200507040211.j642BL6f005488@laptop11.inf.utfsm.cl>
 <028601c581a0$cb1f3e20$2800000a@pc365dualp2> <dan077$n4t$1@sea.gmane.org>
 <200507082026.49404.tomlins@cam.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jul 2005, Ed Tomlinson wrote:

>
> No Flame from me.  One thing to remember is that Hans and friends _have_ supported
> R3 for years.  This is an undisputed fact.  Second third parties have be able to add much
> function (like journaling) to R3 so the code must be sort of readable...  With R4 they have
> created a new FS that is _fast_ and _can_ do things no other FS can - I also expect they have
> written cleaner code...  Why are we fighting about adding this sort of function to the kernel?
> Yes it may not be the absolute best way to do things.  How many times has tcpip be rewritten
> for linux?  The answer is more than once.  Lets put R4 in, see how it works, generalize the ideas
> and if we have to rewrite and rethink part of it lets do so.

remember that Hans is on record (over a year ago) arguing that R3 should 
not be fixed becouse R4 was replacing it.

This type of thing is one of the reasons that you see arguments that 
aren't 'purely code-related' becouse the kernel folks realize that _they_ 
will have to maintain the code over time, Hans and company will go on and 
develop R5 (R10, whatever) and consider R4 obsolete and stop maintaining 
it.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
