Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbTIXDzv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 23:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbTIXDzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 23:55:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:63156 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261354AbTIXDzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 23:55:50 -0400
Date: Tue, 23 Sep 2003 20:54:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Larry McVoy <lm@bitmover.com>
cc: Rik van Riel <riel@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       <andrea@kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: Re: log-buf-len dynamic
In-Reply-To: <20030924034552.GB7887@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0309232051330.27940-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Larry, I think you remember the good old days of SunOS, when 16MB of RAM 
was a lot, and people expected less of their hardware. In particular, 
interactive programs used to have a _tiny_ footprint. Often even under X.

Then we put Solaris, Motif and CDE on those suckers, and it was horrible.

Yeah, SunOS was nice. But I really think it's the access patterns that 
changed.

			Linus

