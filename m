Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265180AbUETQBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265180AbUETQBE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 12:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbUETQBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 12:01:03 -0400
Received: from fire.osdl.org ([65.172.181.4]:17570 "EHLO fire-2.osdl.org")
	by vger.kernel.org with ESMTP id S265180AbUETQAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 12:00:14 -0400
Subject: Re: 2.6.6-mm4 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Stan Bubrouski <stan@ccs.neu.edu>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1085001225.9697.4.camel@duergar>
References: <20040519040421.61263a43.akpm@osdl.org>
	 <1084983767.12134.1.camel@cherrybomb.pdx.osdl.net>
	 <1085001225.9697.4.camel@duergar>
Content-Type: text/plain
Message-Id: <1085068793.4420.1.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 20 May 2004 08:59:54 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-19 at 14:13, Stan Bubrouski wrote:
> On Wed, 2004-05-19 at 12:22, John Cherry wrote:
> <SNIP>
> > Kernel            bzImage   bzImage  bzImage  modules  bzImage  modules
> >                 (defconfig) (allno) (allyes) (allyes) (allmod) (allmod)
> > --------------- ---------- -------- -------- -------- -------- --------
> > 2.6.6-mm3         0w/0e     0w/0e   112w/9w    5w/0e   2w/5e    106w/1e
> > 2.6.6-mm3         3w/9e     0w/0e   120w/26w   5w/0e   2w/0e    114w/10e
> > 2.6.6-mm2         4w/11e    0w/0e   120w/24w   6w/0e   2w/0e    118w/9e
> > 2.6.6-mm1         1w/0e     0w/0e   118w/25w   6w/0e   2w/0e    114w/10e
>                                            /\
> Why are these w/w and not w/e =============!!
> 
> If I'm misunderstanding something please ignore, but me thinks those 'w'
> should be 'e', correct?

Typo.  Should be w/e.

John



