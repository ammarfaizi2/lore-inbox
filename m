Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268614AbRHWPjC>; Thu, 23 Aug 2001 11:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268996AbRHWPiw>; Thu, 23 Aug 2001 11:38:52 -0400
Received: from [216.151.155.121] ([216.151.155.121]:3590 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S268614AbRHWPin>; Thu, 23 Aug 2001 11:38:43 -0400
To: John Weber <weber@nyc.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext2 2GB Limit?
In-Reply-To: <3B851EE9.80406@nyc.rr.com>
From: Doug McNaught <doug@wireboard.com>
Date: 23 Aug 2001 11:38:37 -0400
In-Reply-To: John Weber's message of "Thu, 23 Aug 2001 11:19:05 -0400"
Message-ID: <m3pu9meqgy.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Weber <weber@nyc.rr.com> writes:

> Is the 2GB limit on files for ext2 only true for linux 2.2.x on intel?

Well, for large files on Intel, you need 2.4.x (or 2.2 with LFS
patches) plus a reasonably recent glibc, plus utilities compiled
properly.

So you're generally right, but there are some caveats.

-Doug
-- 
Free Dmitry Sklyarov! 
http://www.freesklyarov.org/ 

We will return to our regularly scheduled signature shortly.
