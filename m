Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267754AbRGURPo>; Sat, 21 Jul 2001 13:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267756AbRGURPe>; Sat, 21 Jul 2001 13:15:34 -0400
Received: from ns.suse.de ([213.95.15.193]:18701 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S267754AbRGURPW>;
	Sat, 21 Jul 2001 13:15:22 -0400
Date: Sat, 21 Jul 2001 19:15:26 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: "peter k." <spam-goes-to-dev-null@gmx.net>
Cc: David Schwartz <davids@webmaster.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.7: wtf is "ksoftirqd_CPU0"
In-Reply-To: <002f01c11202$60f22100$c20e9c3e@host1>
Message-ID: <Pine.LNX.4.30.0107211913550.10044-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sat, 21 Jul 2001, peter k. wrote:

> why wasnt it run in previous kernels?

Because it was only added to mainline in 2.4.7

> im just wondering why it suddenly
> appeared without anyone saying a word about it ;)

>From the changelog...

-pre8:
- Paul Mackerras: PPC updates (softirq)

-pre5:
- Andrea Arkangeli: softirq cleanups and fixes, and everybody is happy
  again (ie I changed some details to make me happy ;)

There were also several discussions about Andreas ksoftirq patches
a few weeks back.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

