Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265885AbSLSRkR>; Thu, 19 Dec 2002 12:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265886AbSLSRkR>; Thu, 19 Dec 2002 12:40:17 -0500
Received: from [81.2.122.30] ([81.2.122.30]:2824 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265885AbSLSRkQ>;
	Thu, 19 Dec 2002 12:40:16 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212191800.gBJI03ZT002284@darkstar.example.net>
Subject: Re: Dedicated kernel bug database
To: dank@kegel.com (Dan Kegel)
Date: Thu, 19 Dec 2002 18:00:03 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E020604.80703@kegel.com> from "Dan Kegel" at Dec 19, 2002 09:46:44 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Following on from yesterday's discussion about there not being much
> > interaction between the kernel Bugzilla and the developers, I began
> > wondering whether Bugzilla might be a bit too generic to be suited to
> > kernel development, and that maybe a system written from the ground up
> > for reporting kernel bugs would be better?
> > 
> > I.E. I am prepared to write it myself, if people think it's
> > worthwhile.
> 
> Quoting Linus
> (http://marc.theaimsgroup.com/?l=linux-kernel&m=103911905214446&w=2):
> > And many things _can_ be done without throwing out old designs.
> > Implementation improvements are quite possible without trying to make
> > something totally new to the outside. ...
> > 
> > Not throwing out the baby with the bath-water doesn't mean that you cannot
> > improve the system. I'm only arguing against stupid people who think they
> > need a revolution to improve - most real improvements are evolutionary.

True, but there is always a point where you have to say, "This isn't
working, we need to re-write it".  Coding by cutting and pasting
existing code is not a great idea.

> I bet the thing to do is to spend some time as one of the
> elves who make bugzilla.kernel.org work smoothly despite
> the software; then figure out what incremental tweak you
> can make to the software to make the elves' and users' lives
> better.

I am not prepared to start editing the existing Bugzilla code - there
is nothing about it that I think it right at the moment.  I could
write a better bug tracking database in a couple of weeks if I wanted
to.

John.
