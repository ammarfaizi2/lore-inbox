Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264727AbSJUESA>; Mon, 21 Oct 2002 00:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264729AbSJUESA>; Mon, 21 Oct 2002 00:18:00 -0400
Received: from pop018pub.verizon.net ([206.46.170.212]:12529 "EHLO
	pop018.verizon.net") by vger.kernel.org with ESMTP
	id <S264727AbSJUER7>; Mon, 21 Oct 2002 00:17:59 -0400
Message-Id: <200210210420.g9L4KeBh005478@pool-141-150-241-241.delv.east.verizon.net>
Date: Mon, 21 Oct 2002 00:20:37 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6: Shortlist of Missing Features
References: <Pine.LNX.4.44L.0210192357430.22993-100000@imladris.surriel.com> <Pine.LNX.4.44.0210201444460.8911-100000@serv> <20021021135137.2801edd2.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021021135137.2801edd2.rusty@rustcorp.com.au>; from rusty@rustcorp.com.au on Mon, Oct 21, 2002 at 01:51:37PM +1000
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at pop018.verizon.net from [141.150.241.241] at Sun, 20 Oct 2002 23:24:00 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> On Sun, 20 Oct 2002 14:59:58 +0200 (CEST)
> Roman Zippel <zippel@linux-m68k.org> wrote:
> > But now would be a good time to recapitulate things which Linus might have
> > forgotten in the patching frenzy.
> 
> Yes.  If we only consider new arch-independent features which are actively
> being pushed at the moment and are feature complete, I get the following
> (much stolen from Guilluame: thanks!):
> 
> - Kernel Probes  (Vamsi Krishna S)

You indicated in your last repost that Linus had commented on the code
which would imply he's planning to add it, but obviously he hasn't.

Maybe now would be a good time to share some of the accompanying code
that makes use of kprobes to get people interested.  I've been playing
with it for a month now and have been patiently waiting for you to
share the rest of the code.

-- 
Skip
