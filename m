Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262967AbTIARDK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 13:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbTIARCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 13:02:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:58531 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263154AbTIARAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 13:00:20 -0400
Date: Mon, 1 Sep 2003 09:59:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
cc: Larry McVoy <lm@work.bitmover.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Larry McVoy <lm@bitmover.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>, <ak@suse.de>
Subject: Re: bitkeeper comments
In-Reply-To: <20030901170218.A24713@infradead.org>
Message-ID: <Pine.LNX.4.44.0309010956390.7908-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 1 Sep 2003, Christoph Hellwig wrote:
> 
> But we're not going to retroactively censor commit messages.

Actually, I do that all the time. In fact, it was I who asked Larry to add 
the "bk comment" command in to make it easy to do so.

The thing is, it's hard to do after the message has already gone out into 
the public - but I fix up peoples email commentary by hand both in the 
email and often later after it has hit my BK tree too. I try to fix 
obvious typos, and just generally make the things more readable.

And if the comment was wrong, then it should be fixed. Not because of any 
"censorship", but because it's misleading if the comment says it fixes 
something it doesn't fix - and that might make people overlook the _real_ 
thing the change does.

		Linus

