Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280983AbRKLUl7>; Mon, 12 Nov 2001 15:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280982AbRKLUlt>; Mon, 12 Nov 2001 15:41:49 -0500
Received: from freeside.toyota.com ([63.87.74.7]:9488 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S280991AbRKLUl3>; Mon, 12 Nov 2001 15:41:29 -0500
Message-ID: <3BF033F0.D544EF6B@lexus.com>
Date: Mon, 12 Nov 2001 12:41:21 -0800
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: joeja@mindspring.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: loop back broken in 2.2.14
In-Reply-To: <Springmail.105.1005586843.0.91657700@www.springmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

joeja@mindspring.com wrote:

> Okay, I can delete out those two lines to get loop working.
>
> Is 2.4.x really a stable tree?  Or should I wait for 2.4.25 before I consider it really stable?

If by stable you mean "unchanging", of course not -

much development is still happening.

If however by stable you mean "does not crash",
it has been very stable here, with a few known
needed patches applied.  2.4.14 is stable for me
on all systems, but compaq smart controllers do
need a small patch - I am also running the low
latency and/or preempt patches with excellent
stability.

cu

jjs


