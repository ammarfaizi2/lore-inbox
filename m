Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267131AbSLaCXx>; Mon, 30 Dec 2002 21:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267132AbSLaCXx>; Mon, 30 Dec 2002 21:23:53 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:50180 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267131AbSLaCXw>; Mon, 30 Dec 2002 21:23:52 -0500
Date: Mon, 30 Dec 2002 21:30:12 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrew Morton <akpm@digeo.com>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] more deprectation bits
In-Reply-To: <3E0F6F64.DDE742A3@digeo.com>
Message-ID: <Pine.LNX.3.96.1021230212733.8353C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Dec 2002, Andrew Morton wrote:

> We shouldn't generate tons of bogus warnings for something which
> everyone knows about anyway.

You could make the argument that we don't need to generate ANY bogus
warnings. For anything.

My feeling on the issue, there are lots of things in the to-do queue,
filling logs with warnings is a good way to get even more "what does this
warning mean" messages to the list and newsgroups.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

