Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267758AbSLTJ3G>; Fri, 20 Dec 2002 04:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267759AbSLTJ3G>; Fri, 20 Dec 2002 04:29:06 -0500
Received: from [81.2.122.30] ([81.2.122.30]:2564 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267758AbSLTJ3F>;
	Fri, 20 Dec 2002 04:29:05 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212200948.gBK9mrXh000326@darkstar.example.net>
Subject: Re: Dedicated kernel bug database
To: mbligh@aracnet.com (Martin J. Bligh)
Date: Fri, 20 Dec 2002 09:48:53 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <79780000.1040355621@titus> from "Martin J. Bligh" at Dec 19, 2002 07:40:22 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[CC list trimmed]

> > I've got loads of ideas about how we could build a better bug database
> 
> Go ahead, knock yourself out. Come back when you're done.

Not sure what you mean.  I do intend to start coding a new bug
database system today, and I'll announce it on the list when it's
ready.  If nobody likes it, I wasted my time.

> > - for example, we have categories at the moment in Bugzilla.  Why?  We
> > already have a MAINTAINERS file, so say somebody looks up the relevant
> > maintainer in that list, finds them, then goes to enter a bug in
> > Bugzilla.  Now they have to assign it to a category, and different
> > people may well assign the same bug to different categories -
> > immediately making duplicate detection more difficult.
> 
> Have you actually looked at the maintainers file?

Yes.

> It's a twisted mess of outdated information,

Then it should be updated, that is nothing to do with Bugzilla.

> in no well formated order.

Looks easy enough to parse with regular expressions to me.

> The category list in Bugzilla was an attempt to bring some sanity to
> the structure,

By adding an extra layer of abstraction.  I don't agree that that
helps.

> though I won't claim it's perfect. We really need a 3-level tree,
> but that's a fair amount of work to code.

I disagree, (that we need a 3-level tree).

John.
