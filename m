Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264875AbSLVI4c>; Sun, 22 Dec 2002 03:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264877AbSLVI4c>; Sun, 22 Dec 2002 03:56:32 -0500
Received: from [81.2.122.30] ([81.2.122.30]:1796 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S264875AbSLVI4b>;
	Sun, 22 Dec 2002 03:56:31 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212220916.gBM9GSlV000224@darkstar.example.net>
Subject: Re: Dedicated kernel bug database
To: Hell.Surfers@cwctv.net
Date: Sun, 22 Dec 2002 09:16:27 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <0725500480216c2DTVMAIL7@smtp.cwctv.net> from "Hell.Surfers@cwctv.net" at Dec 22, 2002 02:50:47 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > I've got loads of ideas about how we could build a better bug
> > > > database

> > > Go ahead, knock yourself out. Come back when you're done.

> > Not sure what you mean.  I do intend to start coding a new bug
> > database system today, and I'll announce it on the list when it's
> > ready.  If nobody likes it, I wasted my time.

> What are your ideas???

* Automatic parsing of things like .config files and oopsen.

* Version tracking that is more suited to a codebase that has at least
  5 very active trees.

* Fully controlable by E-Mail, not only web.

Those are the ones I'm most interested in initially.  Other things can
follow.

I'd had a lot of comments saying that it would be better to either add
these ideas to Bugzilla, or to write a generic bug database, and not
make it specific to kernel development.

The reasons I'm _not_ doing either of those is mostly:

* I don't like Bugzilla at all

* It's easy to make a kernel-specific bug database generic, and not so
  easy to make a generic database kernel-specific

Incidently, can your TV set top box browse the web, or just send
E-Mail?  It would be quite cool if you could go through the bug
database using it :-)

John.
