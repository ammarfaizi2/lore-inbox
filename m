Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268125AbTBMWhF>; Thu, 13 Feb 2003 17:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268126AbTBMWgk>; Thu, 13 Feb 2003 17:36:40 -0500
Received: from air-2.osdl.org ([65.172.181.6]:2532 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268125AbTBMWgU>;
	Thu, 13 Feb 2003 17:36:20 -0500
Date: Thu, 13 Feb 2003 14:43:18 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: plars@linuxtestproject.org, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, edesio@task.com.br
Subject: Re: 2.5.60 cheerleading...
Message-Id: <20030213144318.3ddcf2a6.rddunlap@osdl.org>
In-Reply-To: <200302132220.h1DMKtFT011682@turing-police.cc.vt.edu>
References: <200302132154.h1DLs3ar012874@darkstar.example.net>
	<1045173477.28494.66.camel@plars>
	<200302132220.h1DMKtFT011682@turing-police.cc.vt.edu>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2003 17:20:55 -0500
Valdis.Kletnieks@vt.edu wrote:

| On Thu, 13 Feb 2003 15:57:56 CST, Paul Larson said:
| 
| > Since Linus hasn't chimed in yet, I'm guessing that's exactly what
| > happened.  I'm not trying to improve his workflow, but rather the
| > workflow of anyone who might be interested in getting more involved in
| > 2.5 testing.
| 
| What would help a lot of people (certainly me, at least), would be if
| somebody kept a well-publicized "already known errata" list along with
| (possibly unofficial) work-around patches.  Something along the line of:
| 
| compile fails in drivers/widget/fooby.c with error:
| undefined structure member 'blat' in line 1149.
| To fix:   apply <this patch>

Yes, I agree, that would be helpful.

I try to keep current lkml/etc patches for fixes/cleanups to the
latest kernel, and I've thought about a way to post them, but it's
too time-consuming a task, especially when it's not one's job
to do that.


| On Thu, 13 Feb 2003 22:11:17 +0000 (GMT), John Bradford said:
| 
| > You can always use 2.5.X-BK1 to get the fixes that we would probably
| > have been in 2.5.X if Linus had done more extensive testing on it
| > before releasing it.
| 
| Almost but not quite what I meant - unless -BK1 is reserved for after-release
| whoops and doesn't contain "new stuff for release N+1".   If -BK1 is only
| bugfixes, that would be good.  


--
~Randy
