Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262766AbSJCHKN>; Thu, 3 Oct 2002 03:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262767AbSJCHKN>; Thu, 3 Oct 2002 03:10:13 -0400
Received: from [212.3.242.3] ([212.3.242.3]:766 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id <S262766AbSJCHKM>;
	Thu, 3 Oct 2002 03:10:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: DevilKin <devilkin-lkml@blindguardian.org>
To: Tobias Ringstrom <tori@ringstrom.mine.nu>
Subject: Re: 2.5.40: AT keyboard input problem
Date: Thu, 3 Oct 2002 09:15:16 +0200
User-Agent: KMail/1.4.1
References: <Pine.LNX.4.44.0210030846180.11746-100000@boris.prodako.se>
In-Reply-To: <Pine.LNX.4.44.0210030846180.11746-100000@boris.prodako.se>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210030915.16516.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 October 2002 08:59, Tobias Ringstrom wrote:
> While 2.5 has worked better than I hoped for so far, I do have a problem
> with the new input layer (I think) that is easily reproducible, and quite
> irritating.

I have a similar problem, first noted when using the SysRQ.

With the 2.4.x kernels i can press Alt-SysRQ, and then press the keys I want 
successively (e.g. S M O for Sync Umount Off). Now i have to release 
Alt-SysRQ everytime, and 1/2 of the time it doesn't recognize the press i 
gave.

Also, the Alt key tends to get stuck now and again, and sometimes for no 
reason i get multiple chars when I only strike a key once.

Odd behaviour.

DK
-- 
You should never wear your best trousers when you go out to fight for
freedom and liberty.
		-- Henrik Ibsen

