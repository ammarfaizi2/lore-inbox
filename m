Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWDILi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWDILi7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 07:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWDILi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 07:38:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:20389 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750730AbWDILi6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 07:38:58 -0400
X-Authenticated: #14349625
Subject: Re: [patch][rfc] quell interactive feeding frenzy
From: Mike Galbraith <efault@gmx.de>
To: bert hubert <bert.hubert@netherlabs.nl>
Cc: Con Kolivas <kernel@kolivas.org>, lkml <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <20060409111436.GA26533@outpost.ds9a.nl>
References: <1144402690.7857.31.camel@homer>
	 <200604072256.27665.kernel@kolivas.org> <1144417064.8114.26.camel@homer>
	 <200604072356.03580.kernel@kolivas.org> <1144419294.14231.7.camel@homer>
	 <20060409111436.GA26533@outpost.ds9a.nl>
Content-Type: text/plain
Date: Sun, 09 Apr 2006 13:39:38 +0200
Message-Id: <1144582778.13991.10.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-04-09 at 13:14 +0200, bert hubert wrote:
> On Fri, Apr 07, 2006 at 04:14:54PM +0200, Mike Galbraith wrote:
> > Ok.  Do we then agree that it makes 2.6 unusable for small servers, and
> > that this constitutes a serious problem? :)
> 
> You sure? I may be down there in userspace dirt with the other actual Linux
> users, but I hadn't noticed.

Ok, unusable may be overstated.  Nonetheless, that bit of code causes
serious problems.  It makes my little PIII/500 test box trying to fill
one 100Mbit local network unusable.  That is not overstated.

	-Mike

