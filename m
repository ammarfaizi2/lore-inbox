Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290185AbSAQT0d>; Thu, 17 Jan 2002 14:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290190AbSAQT00>; Thu, 17 Jan 2002 14:26:26 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:64012 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S290185AbSAQT0R>; Thu, 17 Jan 2002 14:26:17 -0500
Date: Thu, 17 Jan 2002 14:26:03 -0500
Message-Id: <200201171926.OAA02791@gatekeeper.tmr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: floating point exception
Newsgroups: mail.linux-kernel
In-Reply-To: <1011211577.1617.4.camel@sector17.home.at>
In-Reply-To: <20020116221454.12e55709.bruce@ask.ne.jp>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1011211577.1617.4.camel@sector17.home.at>,
Christian Thalinger  <e9625286@student.tuwien.ac.at> wrote:
| On Wed, 2002-01-16 at 14:14, Bruce Harada wrote:
| > On Wed, 16 Jan 2002 12:58:35 +0100 (CET)
| > Dave Jones <davej@suse.de> wrote:
| > 
| > > On 16 Jan 2002, Christian Thalinger wrote:
| > > 
| > > > I mentioned in my first mail the dual tyan, so athlon xp, no fpu
| > > > emulator ;-) and no oops messages.
| > > 
| > > Dual Athlon XP problem. Thanks for playing.
| > 
| > Interesting. That's the first actual report I've seen of problems caused by
| > using XPs instead of MPs. I'd been wondering if I could get away with XPs for
| > my next SMP box; now I know better ;)
| 
| Don't be too scared. Everything works except this seti thingy.

  Does this run correctly for UP? And is this the right version of
setiathome for this CPU. Not using SSE7, 4Dthen, or some other
proprietary FP method? And until it is proven to work with the MP part,
should it ever actually be shipped instead of advertized, I wouldn't be
totally sure about XP or kernel being at fault, or even RAM problems
under load, etc.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
