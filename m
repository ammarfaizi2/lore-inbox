Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279438AbRJWNsp>; Tue, 23 Oct 2001 09:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279437AbRJWNsf>; Tue, 23 Oct 2001 09:48:35 -0400
Received: from newssvr17-ext.news.prodigy.com ([207.115.63.157]:18405 "EHLO
	newssvr17.news.prodigy.com") by vger.kernel.org with ESMTP
	id <S279438AbRJWNs2>; Tue, 23 Oct 2001 09:48:28 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
Newsgroups: linux.dev.kernel
Subject: Re: rtl8139 drivers
In-Reply-To: <3BD48BAD.4936C0E6@www.IN.gov>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: davidsen@deathstar.prodigy.com (Bill Davidsen)
Message-ID: <ezeB7.3660$eo5.624476272@newssvr17.news.prodigy.com>
NNTP-Posting-Host: 192.168.192.240
X-Complaints-To: abuse@prodigy.net
X-Trace: newssvr17.news.prodigy.com 1003844938 000 192.168.192.240 (Tue, 23 Oct 2001 09:48:58 EDT)
NNTP-Posting-Date: Tue, 23 Oct 2001 09:48:58 EDT
Date: Tue, 23 Oct 2001 13:48:58 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BD48BAD.4936C0E6@www.IN.gov>,
Greg Swallow <gswallow@www.IN.gov> wrote:

| I just installed linux on a box with a builtin Realtek 8139 chipset. 
| Using the 8139too.o module caused all kinds of performance problems, and
| there are  suspicious statements in the 8139too.txt file:
| 
| THIS DRIVER IS A DEVELOPMENT RELEASE FOR A DEVELOPMENT KERNEL.  DO NOT
| USE IN A PRODUCTION ENVIRONMENT.
| 
| However, I've used Donald Becker's rtl8139 driver in the past without
| issues, and I'm using them now with v2.4.10.  I would like to request
| that the stable code go back in place, please -- perhaps users can
| choose between rtl8139 and 8139too?

  I think you take that warning a bit too seriously... However, if you
are having problem please report, don't just find some old code (which
was dropped because it didn't support many current cards) and forget it.

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.
