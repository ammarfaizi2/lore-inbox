Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268110AbTBMSNl>; Thu, 13 Feb 2003 13:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268134AbTBMSNl>; Thu, 13 Feb 2003 13:13:41 -0500
Received: from [81.2.122.30] ([81.2.122.30]:24071 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S268110AbTBMSNk>;
	Thu, 13 Feb 2003 13:13:40 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302131823.h1DINeZh016257@darkstar.example.net>
Subject: Re: 2.5.60 cheerleading...
To: plars@linuxtestproject.org (Paul Larson)
Date: Thu, 13 Feb 2003 18:23:40 +0000 (GMT)
Cc: davej@codemonkey.org.uk, edesio@ieee.org, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, edesio@task.com.br
In-Reply-To: <1045159485.28494.47.camel@plars> from "Paul Larson" at Feb 13, 2003 12:04:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > How about a quick note out to lkml that says "The current bk is
> > > what I'm going to release at <NN Time> today unless someone
> > > gives me a good reason not to."?
> > Why?  That would just delay releases, and make more work for Linus.
> What I just suggested would be a short 1 line note to lkml.  I know he's
> very busy, but what's that, like 10 seconds?

10 seconds, plus the time waiting around for replies, and the time
spent reading the replies.

> > If a release is badly broken, another one is usually quick to follow
> > it, anyway.
> There's usually a lag of 30min to an hour between the last changeset and
> the the one that changes the version tag anyway.  I would
> hope/assume(dangerous) this is when it's beeing built and tested.  One
> more script to that mix that runs a subset of ltp might add an
> additional 5 min.  Alternatively, a note of intent to lkml might add a
> few seconds to that delay.
> 
> If I counted timezones etc. right, here's a quick picture of the number
> of minutes between the last changeset and the changeset that tagged it
> with the version number:
> 2.5.60 52 min.
> 2.5.59 42 min.
> 2.5.58 31 min.
> 2.5.57 16 min.
>  *** 2.5.58 was release something like 12 hours later
> 
> Is it less work to do a few minutes of extra testing, or go through
> another release in the same day?

Probably less work for Linus to go through another release, plus it
means that people who are not testing -bk snapshots for whatever
reason are more involved in the development process.

John.
