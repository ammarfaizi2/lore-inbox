Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261443AbSJUPyC>; Mon, 21 Oct 2002 11:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261450AbSJUPxy>; Mon, 21 Oct 2002 11:53:54 -0400
Received: from air-2.osdl.org ([65.172.181.6]:48038 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261443AbSJUPwY>;
	Mon, 21 Oct 2002 11:52:24 -0400
Date: Mon, 21 Oct 2002 08:55:56 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <jbradford@dial.pipex.com>
cc: Josh Myer <jbm@joshisanerd.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Docs for 2.4.x -> 2.6.x
In-Reply-To: <200210211550.g9LFoh1u005234@darkstar.example.net>
Message-ID: <Pine.LNX.4.33L2.0210210853370.29900-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2002 jbradford@dial.pipex.com wrote:

| > Would you volunteer to do the same thing for kernel API changes for those
| > of us who don't pay enough attention to the list?
|
| Well, I'm certainly willing to spare the time to do it, but I'm not
| sure that I'm particularly qualified to - the 2.4->2.6 doc would be
| fairly straightforward for me, but documenting API changes in a useful
| way may well require a better understanding of C than I have, (not
| sure what I'd be letting myself in for - the only C I've done is
| mainly games and other user mode stuff).
|
| > I have a few random drivers that aren't in mainline, so i always wind up
| > porting to new kernels (they're trivial, so it's not a big deal, but
| > sometimes it's annoying to find changes).
| >
| > Or is someone else already doing this wonderfully sexy job?
|
| It's possible they might be, I'm not sure...
|
| John.
| -

I got the impression that the first poster was asking
for user-level 2.4 -> 2.6 migration HOWTO info,
not kernel API changes.  (such as "be sure that all of those
CONFIG_INPU_options are enabled!")

I began keeping 2.5 kernel API changes very early, but then I ran
out of time; there were just so many of them, coming too fast.
Here are the early ones:
  http://www.xenotime.net/linux/linux-port-25x.html

-- 
~Randy
  "Do you need telco grade soundblaster 16 ?" -- Alan Cox

