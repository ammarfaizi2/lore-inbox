Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268111AbTBMWA1>; Thu, 13 Feb 2003 17:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268116AbTBMWA1>; Thu, 13 Feb 2003 17:00:27 -0500
Received: from [81.2.122.30] ([81.2.122.30]:21252 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S268111AbTBMWAZ>;
	Thu, 13 Feb 2003 17:00:25 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302132211.h1DMBH6p019271@darkstar.example.net>
Subject: Re: 2.5.60 cheerleading...
To: plars@linuxtestproject.org (Paul Larson)
Date: Thu, 13 Feb 2003 22:11:17 +0000 (GMT)
Cc: jgarzik@pobox.com, davej@codemonkey.org.uk, edesio@ieee.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1045173477.28494.66.camel@plars> from "Paul Larson" at Feb 13, 2003 03:57:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Likewise with kernel releases - fewer, larger releases work fine and
> > mean less effort for developers, unless something breaks, in which
> > case there is a lot to go through to locate the problem, and people
> > who can't boot the broken kernel have to wait longer to test other
> > things that were newly merged in that release.
> This was exactly what I was getting at.  I suspect that there are a good
> number of people that try to boot a 2.5 kernel for testing, run into
> immediate problems, and shelve the idea of 2.5 testing for a couple of
> months because of an immediate appearance that 2.5 is too unstable to
> test.  I've seen frequent griping that not enough testing happens, the
> idea is to get it to a point where more people can test it _without_
> adding a huge delay or making a huge gap between releases.

I can see what you mean, but realistically, I don't see how it's
practical.

You can always use 2.5.X-BK1 to get the fixes that we would probably
have been in 2.5.X if Linus had done more extensive testing on it
before releasing it.

John.
