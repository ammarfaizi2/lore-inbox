Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318802AbSHPX7Q>; Fri, 16 Aug 2002 19:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318942AbSHPX7Q>; Fri, 16 Aug 2002 19:59:16 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57863 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318802AbSHPX7P>; Fri, 16 Aug 2002 19:59:15 -0400
Date: Fri, 16 Aug 2002 17:06:19 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Larry McVoy <lm@bitmover.com>
cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: IDE?
In-Reply-To: <Pine.LNX.4.44.0208161657240.1674-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208161702370.1674-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Aug 2002, Linus Torvalds wrote:
> 
> I actually don't think it's the people as much as it is the ridiculous 
> linkages inside ide.c and the hugely complicated rules. The code is messy.

Note: it _is_ the people too, don't get me wrong. But in other areas we 
have people like Al Viro, who can drive grown men to cry (and drink) with 
his not-very-polite postings. And in those areas it hasn't been a huge 
problem, even though some people probably take a valium or two before they 
dare open emails from Al.

So the messiness and interconnectedness of the IDE layer just seems to
bring the people problem to a sharp and ugly point. The absolute lack of
communication skills wrt IDE among the people who have worked on it has
been stunning, and that probably _is_ because the code is so hard to even 
talk about.

		Linus

