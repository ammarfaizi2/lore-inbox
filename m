Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbTIYShY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 14:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbTIYShY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 14:37:24 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64595 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261667AbTIYShT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 14:37:19 -0400
To: Dave Jones <davej@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, andrea@kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: log-buf-len dynamic
References: <Pine.LNX.4.44.0309231924540.27467-100000@home.osdl.org>
	<m1n0csiybu.fsf@ebiederm.dsl.xmission.com>
	<20030925173648.GA19626@redhat.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Sep 2003 12:35:42 -0600
In-Reply-To: <20030925173648.GA19626@redhat.com>
Message-ID: <m1fzikium9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> writes:

> On Thu, Sep 25, 2003 at 11:15:33AM -0600, Eric W. Biederman wrote:
> 
>  > And for the core kernel development this is true.  There are subprojects
>  > that are currently using BK that you can't even get the code without
>  > BK.  And the only reason they are using BK is they are attempting to
>  > following how Linux is managed.  So having the Linux kernel
>  > development use BK does have some down sides.
> 
> I was expecting this to come up when Linus first made sparse publically
> available only by bitkeeper, so I started the nightly snapshots.
> If there's any other Linux related project that's bitkeeper only
> let me know, and I'll be happy to host nightly snapshots of that too.

The linux infiniband project, is actually what I was thinking of.
http://infiniband.sourceforge.net/

Eric
