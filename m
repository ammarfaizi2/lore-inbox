Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262831AbSI3SjS>; Mon, 30 Sep 2002 14:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262833AbSI3SjS>; Mon, 30 Sep 2002 14:39:18 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:53519 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262831AbSI3SjP>; Mon, 30 Sep 2002 14:39:15 -0400
Date: Mon, 30 Sep 2002 14:37:04 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: v2.6 vs v3.0
In-Reply-To: <Pine.LNX.4.44.0209281826050.2198-100000@home.transmeta.com>
Message-ID: <Pine.LNX.3.96.1020930135405.20863C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Sep 2002, Linus Torvalds wrote:

> However, I'll believe that when I see it. Usually people don't complain 
> during a development kernel, because they think they shouldn't, and then 
> when it becomes stable (ie when the version number changes) they are 
> surprised that the behabviour didn't magically improve, and _then_ we get 
> tons of complaints about how bad the VM is under their load.

Part of this is because people who complain often get answers which sound
a lot like "what do you expect, it's a test kernel," or "you have the
source, go fix it," or even "if you don't like go run Windows." This list
is FAR more cordial than newsgroups, but I have seen people who suggested
an improvement get invited to submit a patch.

The other reason is the "it must be me" effect, if something doesn't work
for the user there is a general reaction that something must be configured
wrong.

Anyway that's my impression of why the complaints come as you say, I think
it's going to happen regardless of the version number. 

For what it's worth the changes feel more like 2.2 to 2.4 than 1.2.13 to
2.0, but as long as you don't call it Windows I don't really care;-) 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

