Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVF2Dx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVF2Dx4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 23:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbVF2Dx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 23:53:56 -0400
Received: from smtpout.mac.com ([17.250.248.86]:31172 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261388AbVF2Dxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 23:53:53 -0400
In-Reply-To: <2661.10.10.10.24.1120004702.squirrel@linux1>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org> <20050624064101.GB14292@pasky.ji.cz> <20050624123819.GD9519@64m.dyndns.org> <20050628150027.GB1275@pasky.ji.cz> <20050628180157.GI12006@waste.org> <62CF578B-B9DF-4DEA-8BAD-041F357771FD@mac.com> <3886.10.10.10.24.1119991512.squirrel@linux1> <20050628221422.GT12006@waste.org> <3993.10.10.10.24.1119997389.squirrel@linux1> <20050628224946.GU12006@waste.org> <4846.10.10.10.24.1119999568.squirrel@linux1> <40A9C7C2-1AFE-45BC-90A5-571628304479@mac.com> <1765.10.10.10.24.1120001856.squirrel@linux1> <40A4071C-ED45-4280-928F-BCFC8761F47E@mac.com> <2661.10.10.10.24.1120004702.squirrel@linux1>
Mime-Version: 1.0 (Apple Message framework v730)
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <12B6F9A5-81F8-46BD-A05D-B9FA1A70A9FF@mac.com>
Cc: Matt Mackall <mpm@selenic.com>, Petr Baudis <pasky@ucw.cz>,
       Christopher Li <hg@chrisli.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Tue, 28 Jun 2005 23:53:47 -0400
To: Sean <seanlkml@sympatico.ca>
X-Mailer: Apple Mail (2.730)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 28, 2005, at 20:25:02, Sean wrote:
> there will be a price to pay if the linux community fragments over  
> choice
> of scm.

I don't agree.  With the current set of SCMs, I don't think it will  
be long
before somebody invents a gitweb/Mercurial/whatever gateway, such  
that I can
"hg serve" from my Mercurial repository and have Linus "git pull" from a
multiprotocol bridge.

> the good news is that we're no longer locked into the whims of
> some proprietary system.  so it should be straight forward for  
> those who
> choose any tool to work with those who've chosen another.  this is  
> already
> evidenced by the fact that the git repository is pulled and re- 
> exeported
> with mecurial.

I agree completely!  Cheers to the end of proprietary revision storage!

> anyway, all the best, just wish you guys would spend less time  
> trying to
> convert git users and more time advancing your own tool.

A project with no users isn't much of a project, now is it?  In any  
case,
this thread has long since passed its usefulness, so let's let it  
die, ok?

Cheers,
Kyle Moffett

--
I lost interest in "blade servers" when I found they didn't throw  
knives at people who weren't supposed to be in your machine room.
   -- Anthony de Boer

