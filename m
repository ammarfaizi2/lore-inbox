Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbTIYS1V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 14:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbTIYSZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 14:25:26 -0400
Received: from h24-78-210-69.ss.shawcable.net ([24.78.210.69]:52997 "HELO
	discworld.dyndns.org") by vger.kernel.org with SMTP id S261685AbTIYSXy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 14:23:54 -0400
Date: Thu, 25 Sep 2003 12:28:38 -0600
From: Charles Cazabon <linux@discworld.dyndns.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Larry McVoy <lm@bitmover.com>
Subject: Re: log-buf-len dynamic
Message-ID: <20030925122838.A16288@discworld.dyndns.org>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Larry McVoy <lm@bitmover.com>
References: <m1n0csiybu.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.44.0309251026550.29320-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0309251026550.29320-100000@home.osdl.org>; from torvalds@osdl.org on Thu, Sep 25, 2003 at 10:30:58AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
> On 25 Sep 2003, Eric W. Biederman wrote:
> 
> > And for the core kernel development this is true.  There are subprojects
> > that are currently using BK that you can't even get the code without BK.

> That's actually a pretty good point.
[...]
> I don't know what the solution to it might be

Perhaps BitMover could release a client that can't do anything but keep a
local (unmodified) tree in sync with a public repository tree, so that the
"politically objectionable" (to some) parts of the BK license don't matter.

In an idea world, this read-only client could be released in source form, but
I'm under no illusions there :).

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                            <linux@discworld.dyndns.org>
GPL'ed software available at:     http://www.qcc.ca/~charlesc/software/
-----------------------------------------------------------------------
