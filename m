Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276247AbRI1TQf>; Fri, 28 Sep 2001 15:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276249AbRI1TQ0>; Fri, 28 Sep 2001 15:16:26 -0400
Received: from [213.97.45.174] ([213.97.45.174]:48653 "EHLO pau.intranet.ct")
	by vger.kernel.org with ESMTP id <S276247AbRI1TQM>;
	Fri, 28 Sep 2001 15:16:12 -0400
Date: Fri, 28 Sep 2001 21:14:22 +0200 (CEST)
From: Pau Aliagas <linux4u@wanadoo.es>
X-X-Sender: <pau@pau.intranet.ct>
To: Rik van Riel <riel@conectiva.com.br>
cc: bill davidsen <davidsen@tmr.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.9-ac16 good perfomer?
In-Reply-To: <Pine.LNX.4.33L.0109281535220.26495-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0109282109590.10387-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2001, Rik van Riel wrote:

> On Fri, 28 Sep 2001, bill davidsen wrote:
>
> > I have been playing with 2.4.9-ac16 and I note that on a small machine
> > (without the highmem issues) it really seems much slower initially.
> > After startx I pop up netscape for a test, and it takes almost 50%
> > longer than 2.4.8-pre3 I've been running since it was new. After that it
> > seems okay but not wildly better, my aim was to be able to use netscape
> > and cdrecord and {anything_else} at the same time.
>
> Mmmm, interesting.  Could you send me a screen worth of
> top output and maybe 10 or 20 lines or so of 'vmstat 1'
> output, both taken while the machine is going through a
> hard time ?
>
> Lets try to resolve this issue while we're at it ;)

I find it the best in 2.4 series :)
Opening a nautilus window in a directory with 1600 pictures taht usually
made the system unusable (a laptop) now doesn't affect much.

An important remaining glitch for me is what happens when the system is
idle for some time, for instance after the screensaver has been running
during lunch time; it takes a few seconds moving from desktop to desktop
til it "swaps in" applications again. Maybe we are throwing away pages too
aggressively?

Pau

