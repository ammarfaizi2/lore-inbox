Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311224AbSCQAoq>; Sat, 16 Mar 2002 19:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311227AbSCQAog>; Sat, 16 Mar 2002 19:44:36 -0500
Received: from dsl-213-023-039-132.arcor-ip.net ([213.23.39.132]:61900 "EHLO
	starship") by vger.kernel.org with ESMTP id <S311225AbSCQAoT>;
	Sat, 16 Mar 2002 19:44:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Larry McVoy <lm@bitmover.com>
Subject: Re: Linux 2.4 and BitKeeper
Date: Sun, 17 Mar 2002 01:39:52 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C90E994.2030702@candelatech.com> <a6teec$sis$1@penguin.transmeta.com> <20020315104705.N29887@work.bitmover.com>
In-Reply-To: <20020315104705.N29887@work.bitmover.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16mOiH-0000mh-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 15, 2002 07:47 pm, Larry McVoy wrote:
> Here's the deal.  I know you guys all think that I'm a genius and
> everything, but I'm actually dumb as a board.  The "design mistake"
> was made so that I could have BK generate pure SCCS files and test that
> I did the same thing as a known working tool, ATT SCCS.  By doing that,
> I easily saved myself a year of design.  Making interleaved deltas work
> is hard for me (we have Rick here now and he's forgotten more about this
> stuff than I'll ever know, but we didn't have him when I wrote the SCCS
> compat weave).
>
> [...]
>
> I'm gonna hack at least make & patch to know about the new format and
> work the way they do now.  So I can have your cake and eat it too.
> If I can't get the FSF to take the changes, we'll just ship 'em,
> we ship diff & patch already, so it's not so hard to alias make='bk make'.

While you're in there, is there any way I can have an option to have the
'shouting' SCCS become .SCCS or something, so a normal listing just shows
the files I'm interested in?

-- 
Daniel
