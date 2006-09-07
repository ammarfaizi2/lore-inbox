Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965287AbWIGBaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965287AbWIGBaF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 21:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965289AbWIGBaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 21:30:05 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:18868 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S965287AbWIGBaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 21:30:00 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Date: Thu, 7 Sep 2006 01:29:46 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <ednsma$hbt$1@taverner.cs.berkeley.edu>
References: <20060907003210.GA5503@clipper.ens.fr> <20060907010127.9028.qmail@web36603.mail.mud.yahoo.com>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1157592586 17789 128.32.168.222 (7 Sep 2006 01:29:46 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Thu, 7 Sep 2006 01:29:46 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Casey Schaufler  wrote:
>In our TCSEC B1 (Old person speak for LSPP)
>evaluation we had to put way too much effort
>into explaining why certain operations that
>had nothing to do with the system security
>policy (e.g. compute resource limitations)
>required privilege. These operations had
>no security implications at all, but since
>they required privilege they were assumed to
>have dire consequences should they be abused.

Well, this is sounding like a pretty weak argument.

It sounds like what you are saying is the evaluators were not thinking
straight when they gave you a hard time about your efforts to do a
better job of implementing the principle of least privilege.  If I
understand the gist of what you are saying correctly, you reduced the
privilege on some processes, and the result was that they complained
more loudly than if you had done nothing.  If so, that's pretty lame.
That doesn't sound to me like the evaluators were thinking very clearly.

And if the evaluators don't really understand how to think clearly about
security, why should we pay any attention to them, anyway?  I see no
reason to design the Linux kernel around the whims of those who don't
understand the technical issues.  Who cares about what the evaluators
think, if they don't have their head screwed on straight?  Personally,
I care more about technical merit than about pleasing folks who don't
understand security.
