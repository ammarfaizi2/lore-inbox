Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262223AbVF1WuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbVF1WuJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 18:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbVF1Wt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 18:49:28 -0400
Received: from smtpout.mac.com ([17.250.248.89]:7921 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261505AbVF1Wrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 18:47:42 -0400
In-Reply-To: <3993.10.10.10.24.1119997389.squirrel@linux1>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org> <20050624064101.GB14292@pasky.ji.cz> <20050624123819.GD9519@64m.dyndns.org> <20050628150027.GB1275@pasky.ji.cz> <20050628180157.GI12006@waste.org> <62CF578B-B9DF-4DEA-8BAD-041F357771FD@mac.com> <3886.10.10.10.24.1119991512.squirrel@linux1> <20050628221422.GT12006@waste.org> <3993.10.10.10.24.1119997389.squirrel@linux1>
Mime-Version: 1.0 (Apple Message framework v730)
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6CD96997-0454-40C0-89B3-AD2A2A7692B3@mac.com>
Cc: Matt Mackall <mpm@selenic.com>, Petr Baudis <pasky@ucw.cz>,
       Christopher Li <hg@chrisli.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Tue, 28 Jun 2005 18:47:36 -0400
To: Sean <seanlkml@sympatico.ca>
X-Mailer: Apple Mail (2.730)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 28, 2005, at 18:23:09, Sean wrote:
> Git is still developing, there will be new ways to seek and cache  
> things
> etc eventually that remove any performance issue.  Git gets this  
> right, it
> concentrates on what is important, stays flexible and trusts that  
> down the
> road as things mature any performance problems can be dealt with.

Have you tried (or even looked at) Mercurial?  I'm now using it for four
different projects that used to be in CVS and I'm loving it.

> It already has some tools that are better than BK ever had (gitk,  
> gitweb,
> etc..)

Likewise for Mercurial, except that IMHO, a from-scratch Mercurial  
pull via
HTTP + Mercurial checkout is faster than a BK or GIT checkout alone.   
And
then there's the fact that it stores the whole mess in a fraction of the
space used by git.

Please, just _try_ it first.  You'll like it, I promise.  (It's also a
much smaller codebase too)

Cheers,
Kyle Moffett

--
I lost interest in "blade servers" when I found they didn't throw  
knives at people who weren't supposed to be in your machine room.
   -- Anthony de Boer

