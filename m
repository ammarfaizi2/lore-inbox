Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261384AbTCGGfa>; Fri, 7 Mar 2003 01:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261386AbTCGGfa>; Fri, 7 Mar 2003 01:35:30 -0500
Received: from vitelus.com ([64.81.243.207]:46344 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S261384AbTCGGf3>;
	Fri, 7 Mar 2003 01:35:29 -0500
Date: Thu, 6 Mar 2003 22:45:52 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@digeo.com>,
       Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
Message-ID: <20030307064552.GA21885@vitelus.com>
References: <Pine.LNX.4.44.0303061819160.14218-100000@localhost.localdomain> <Pine.LNX.4.44.0303060936301.7206-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303060936301.7206-100000@home.transmeta.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 06, 2003 at 09:42:03AM -0800, Linus Torvalds wrote:
> But it was definitely there. 3-5 second _pauses_. Not slowdowns.

I can second this. Using Linux 2.5.5x, untarring a file while
compiling could cause X to freeze for several seconds at a time.
I haven't seen this problem recently, though I do experience my share
of XMMS skips.
