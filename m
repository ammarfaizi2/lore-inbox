Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbTIYRj5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 13:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbTIYRi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 13:38:27 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:36149 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261685AbTIYRhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 13:37:46 -0400
Date: Thu, 25 Sep 2003 18:36:48 +0100
From: Dave Jones <davej@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@osdl.org>, andrea@kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: log-buf-len dynamic
Message-ID: <20030925173648.GA19626@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@osdl.org>, andrea@kernel.org,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Matthew Wilcox <willy@debian.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
	Larry McVoy <lm@bitmover.com>
References: <Pine.LNX.4.44.0309231924540.27467-100000@home.osdl.org> <m1n0csiybu.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1n0csiybu.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 11:15:33AM -0600, Eric W. Biederman wrote:

 > And for the core kernel development this is true.  There are subprojects
 > that are currently using BK that you can't even get the code without
 > BK.  And the only reason they are using BK is they are attempting to
 > following how Linux is managed.  So having the Linux kernel
 > development use BK does have some down sides.

I was expecting this to come up when Linus first made sparse publically
available only by bitkeeper, so I started the nightly snapshots.
If there's any other Linux related project that's bitkeeper only
let me know, and I'll be happy to host nightly snapshots of that too.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
