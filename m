Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262793AbTEAXt6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 19:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262797AbTEAXt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 19:49:57 -0400
Received: from rth.ninka.net ([216.101.162.244]:46553 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S262793AbTEAXtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 19:49:52 -0400
Subject: Re: must-fix list for 2.6.0
From: "David S. Miller" <davem@redhat.com>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
In-Reply-To: <87znm6c3fd.fsf@deneb.enyo.de>
References: <20030429231009$1e6b@gated-at.bofh.it>
	 <87k7dcinxg.fsf@deneb.enyo.de> <1051788267.8772.9.camel@rth.ninka.net>
	 <87znm6c3fd.fsf@deneb.enyo.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051790736.8772.23.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 May 2003 05:05:36 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-01 at 04:27, Florian Weimer wrote:
> "David S. Miller" <davem@redhat.com> writes:
> 
> > On Tue, 2003-04-29 at 21:55, Florian Weimer wrote:
> >> Andrew Morton <akpm@digeo.com> writes:
> >> 
> >> > net/
> >> > ----
> >> 
> >> What about the dst cache DoS attack?
> >
> > Thanks for the lack of detailed description of the problem.
> > Without it nobody can help you.
> 
> Shall I post the exploit?

Don't let me stop you.

You can't expect us to act on anything based upon vague references
to "dst cache DoS" and things like that.

I also would appreciate it if you'd actually at least add the
networking maintainers to the CC: list when asking/discussing
such problems.  Bringing it up on places like linux-net and
netdev@oss.sgi.com would be a good idea too.

Random blather on linux-kernel tends to get ignored.

-- 
David S. Miller <davem@redhat.com>
