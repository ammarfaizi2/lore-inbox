Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279939AbRKIWgM>; Fri, 9 Nov 2001 17:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280246AbRKIWgC>; Fri, 9 Nov 2001 17:36:02 -0500
Received: from [216.151.155.121] ([216.151.155.121]:34577 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S279939AbRKIWfm>; Fri, 9 Nov 2001 17:35:42 -0500
To: "Ben Israel" <ben@genesis-one.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Disk Performance
In-Reply-To: <000201c16963$365e19e0$5101a8c0@pbc.adelphia.net>
From: Doug McNaught <doug@wireboard.com>
Date: 09 Nov 2001 17:35:31 -0500
In-Reply-To: "Ben Israel"'s message of "Fri, 9 Nov 2001 16:04:19 -0500"
Message-ID: <m3ofmbr2rw.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ben Israel" <ben@genesis-one.com> writes:

> Why does my 40 Megabyte per second IDE drive, transfer files at best at 1-2
> Megabytes per second? Can anyone prove that this must be the case? What is
> the most efficient way to convince anyone who reads this that it can't be
> proven because a counter example exists?

I had a drive that did something this (it was really slow on reads and 
normal speed on writes, funnily enough).  I finally compared it to
another drive in the same machine which worked normally and decided
that it was a failing drive (after trying many different kernels).
The replacement works fine.

So don't rule out hardware, either a bad drive or an incompatibility
between your drive and your IDE controller. 

> I wish to be personally CC'ed the answers/comments posted to the list in
> response to this posting.

Say "please" next time.

> This is my first attempt at being part of the process. Please give me some
> time to adjust.

A less arrogant tone would be a good start.

-Doug
-- 
Let us cross over the river, and rest under the shade of the trees.
   --T. J. Jackson, 1863
