Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbTIYUES (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 16:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbTIYUES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 16:04:18 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20820 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261834AbTIYUER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 16:04:17 -0400
To: Larry McVoy <lm@bitmover.com>
Cc: Linus Torvalds <torvalds@osdl.org>, andrea@kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: Re: log-buf-len dynamic
References: <Pine.LNX.4.44.0309231924540.27467-100000@home.osdl.org>
	<m1n0csiybu.fsf@ebiederm.dsl.xmission.com>
	<20030925184906.GD18749@work.bitmover.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Sep 2003 14:02:15 -0600
In-Reply-To: <20030925184906.GD18749@work.bitmover.com>
Message-ID: <m1zngshc1k.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> writes:

> On Thu, Sep 25, 2003 at 11:15:33AM -0600, Eric W. Biederman wrote:
> > In addition there are some major gains to be had in standardizing on a
> > distributed version control system that everyone can use, and
> > unfortunately BK does not fill that position.  So I think it is good
> > that there is enough general discontent it the air that people
> > continue to look for alternatives. 
> 
> Let's just postulate that my claim that this is harder than it looks is
> true.  You don't have to agree with it, just pretend you do.  Given that,
> it's going to be a while before any alternative shows up.  People mumble
> about arch until they go use it for a while and realize it is about 3-5
> years behind BK.  Linus isn't about to step backwards that far.

Nope. I won't.  I would much rather postulate that it is easier than
it looks so someone will get started :)  

> > The current situation with version control is painful.  
> 
> No kidding.  Do you have any suggestions, _realistic_ suggestions, that 
> we could do to help?  Beyond making plain text patches/tarballs available
> from every repo hosted on bkbits?

patches/tarballs and a clear way to find them would certainly help.
And would pretty much put a project on bkbits on par with the non bk
alternatives, for usability.

Eric
