Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbTIYRhm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 13:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbTIYRg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 13:36:29 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:57095 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261551AbTIYRbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 13:31:52 -0400
Date: Thu, 25 Sep 2003 18:31:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: log-buf-len dynamic
Message-ID: <20030925183149.A19774@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Matthew Wilcox <willy@debian.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
	Larry McVoy <lm@bitmover.com>
References: <Pine.LNX.4.44.0309231924540.27467-100000@home.osdl.org> <m1n0csiybu.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m1n0csiybu.fsf@ebiederm.dsl.xmission.com>; from ebiederm@xmission.com on Thu, Sep 25, 2003 at 11:15:33AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 11:15:33AM -0600, Eric W. Biederman wrote:
> And for the core kernel development this is true.  There are subprojects
> that are currently using BK that you can't even get the code without
> BK.  And the only reason they are using BK is they are attempting to
> following how Linux is managed.  So having the Linux kernel
> development use BK does have some down sides.

Stupid argument.  E.g. the ppc folks used BK much longer than Linus.
And there are kernel projects using svn (ieee1394) or cvs that you
can't access without installing svn or cvs.

> In addition there are some major gains to be had in standardizing on a
> distributed version control system that everyone can use, and
> unfortunately BK does not fill that position.  So I think it is good
> that there is enough general discontent it the air that people
> continue to look for alternatives. 

Why should we standardize on one SCM?  That's like we standadize
on Windows for all computers..

