Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbTIWWP3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 18:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263063AbTIWWP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 18:15:28 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:41360
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S262792AbTIWWPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 18:15:24 -0400
Date: Wed, 24 Sep 2003 00:15:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: log-buf-len dynamic
Message-ID: <20030923221528.GP1269@velociraptor.random>
References: <20030923142706.54b2428a.davem@redhat.com> <Pine.LNX.4.44.0309231445210.24527-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309231445210.24527-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 02:53:32PM -0700, Linus Torvalds wrote:
> When you write some code of your own, you get to choose the license. And I 
> haven't seen you make CVS usable - I've only seen you bitch, moan, and 
> complain..

we have cvsps and subversion these days, it's not about cvs only anymore.

if I would know that you will eventually get interested into anything
not bitkeeper I would be glad to hack in this area (I can use some spare
time too) to provide a service to the community. The main reason I will
never use  b*tkeeper is because I want to retain the freedom to do that,
something that you and many others won't be able to do anymore.

But note that cvs+cvsps is already perfectly usable for me, most people
is readonly anyways, and if you would checkin into cvs instead of
b*tkeeper I couldn't notice any difference (except that I could send you
a patch to add the email at the top of the cvs log). So from my part,
using cvsps is just good enough and I've no idea why you call it
"unusable" (just as example see the two patches I extracted in a second,
in the old days I certainly couldn't do that).

There's a chance cvsps is even more friendly than b*tkeeper for my
common usages.

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
	    svn://svn.kernel.org/linux-2.[46]/trunk
