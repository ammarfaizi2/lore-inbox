Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbTLIVzb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 16:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbTLIVzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 16:55:31 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:16259
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262251AbTLIVza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 16:55:30 -0500
Date: Tue, 9 Dec 2003 16:54:00 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Larry McVoy <lm@bitmover.com>
cc: cliff white <cliffw@osdl.org>, hannal@us.ibm.com,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Amy Graf <amy@work.bitmover.com>
Subject: Re: [Lse-tech] Re: Minutes from OSDL talk at LSE call today
In-Reply-To: <20031209214815.GA32633@work.bitmover.com>
Message-ID: <Pine.LNX.4.58.0312091653020.2313@montezuma.fsmlabs.com>
References: <189470000.1070500829@w-hlinder> <20031204033535.GA2370@work.bitmover.com>
 <20031204134517.0c7a4ec4.cliffw@osdl.org> <20031204234454.GA15799@work.bitmover.com>
 <Pine.LNX.4.58.0312091625560.2313@montezuma.fsmlabs.com>
 <20031209214815.GA32633@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Dec 2003, Larry McVoy wrote:

> It's worth pointing out that triggers in open source trees are quite a bit
> more dangerous than in controlled environment.  Carl-Daniel's boss made
> quite a fuss over the fact that triggers are just programs that are run
> and can be used to cause all sorts of problems if people were malicious.
>
> I've toyed with the idea of disabling triggers in openlogging trees
> because of this.  I'm neutral on the topic, it's not like triggers
> are some huge money maker that we need to reserve for the commercial
> version.  If the general feeling is that triggers are useful and people
> will take responsibility for policing their own repos then we'll leave
> them in.  On the other hand, if someone putting a nasty trigger into
> your tree somehow becomes the fault of BitMover because we provided the
> infrastructure then out they go in the next release.

I personally find them very useful, perhaps we should just stick with the
other methods of disabling said functionality.

Thanks

