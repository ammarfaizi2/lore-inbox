Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbTIZRKD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 13:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbTIZRKC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 13:10:02 -0400
Received: from main.gmane.org ([80.91.224.249]:54691 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261632AbTIZRJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 13:09:58 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: John Goerzen <jgoerzen@complete.org>
Subject: Re: log-buf-len dynamic
Date: Fri, 26 Sep 2003 12:09:43 -0500
Organization: Complete.Org
Message-ID: <87n0crsch4.fsf@heinrich.complete.org>
References: <Pine.LNX.4.44.0309231924540.27467-100000@home.osdl.org> <m1n0csiybu.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@complete.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:iJfxHSwsLO4FHrx3Krn3SuXzFrQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before replying, I should let you know that I have made an Arch
repository containing every version of Linux since 0.01 clear through
2.6.0-test5 available at http://arch.debian.org/.  Please see the docs
there for more info.  While I have learned a lot about Arch since then
(particularly relating to proper naming of categories), you should
still be able to use it to experiment with the strengths and
weaknesses of arch, particularly relating to branching and marging.

ebiederm@xmission.com (Eric W. Biederman) writes:

> The current situation with version control is painful.  CVS branches
> poorly and is not distributed.  SVN is not distributed.  ARCH is
> barely distributed and architecturally it makes distributed merging

That is completely wrong wrt arch; in fact, I would say it is the most
intrinsically distributed of any VC system I've seen.  Please see:

Elementary Branches
   http://regexps.srparish.net/tutorial-tla/elementary-branches.html

Development Branches with star-merge
  http://regexps.srparish.net/tutorial-tla/development-branches.html

Introducing Changesets
  http://regexps.srparish.net/tutorial-tla/introducing-changesets.html

-- John

