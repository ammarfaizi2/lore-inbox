Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282554AbRKZVWL>; Mon, 26 Nov 2001 16:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282560AbRKZVWB>; Mon, 26 Nov 2001 16:22:01 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:55303 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S282554AbRKZVVs>; Mon, 26 Nov 2001 16:21:48 -0500
Date: Mon, 26 Nov 2001 16:15:26 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Release Policy [was: Linux 2.4.16  ]
In-Reply-To: <4.3.2.7.2.20011126120940.00b41b20@mail.osagesoftware.com>
Message-ID: <Pine.LNX.3.96.1011126160539.27112J-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001, David Relson wrote:

> At 12:22 PM 11/26/01, Chris Meadors wrote:
> 
> >Aren't all the -pre's pre-finals?  And what if there is a big bug found in
> >the -final, it will obviously be followed up with a -final-final?

All the -pre's are before the final, but not release candidates. I think
the rc until recently has been the one where someone said "we've put a
hell of a lot of new stuff in this..." and concentrated on reported bugs,
if any.

> >I like the ISC's release methods.  The do -rc's (-pre's would be fine for
> >the kernel as it is already established), each -rc fixes problems found
> >with the previous.  When an -rc has been out long enough with no more bug
> >reports they release that code, WITHOUT changes.
 
> I think of -pre releases as beta code - testable and likely broken.  An -rc 
> release would be "possibly broken".  If problems are encountered, fix ONLY 
> those problems to generate the next -rc.  If it's O.K., then make it "final".

Other than some quibbling about nomenclature, that's how I see it. We
always had an alpha version for in-house testing only, then a beta for
selected users, which for Linux would be those who have the guts to run
the downloads, and then a release.

I did commenrcial software development for a few decades and that was
usually the practice, and that's what people like Microsoft were doing
when I did a few beta tests for them. I think it's a good model for Linux
stable kernel series.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

