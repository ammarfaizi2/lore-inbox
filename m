Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264096AbRF3Uj0>; Sat, 30 Jun 2001 16:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264141AbRF3UjQ>; Sat, 30 Jun 2001 16:39:16 -0400
Received: from mail.cs.umn.edu ([128.101.33.100]:41403 "EHLO mail.cs.umn.edu")
	by vger.kernel.org with ESMTP id <S264096AbRF3UjH>;
	Sat, 30 Jun 2001 16:39:07 -0400
To: sl@fireplug.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch.
In-Reply-To: <993825330.30635@whiskey.enposte.net>
	<9hinh4$47a$1@whiskey.enposte.net>
Content-Type: text/plain; charset=us-ascii
From: Raja R Harinath <harinath@cs.umn.edu>
Date: Sat, 30 Jun 2001 15:39:05 -0500
In-Reply-To: <9hinh4$47a$1@whiskey.enposte.net> (sl@whiskey.fireplug.net's
 message of "29 Jun 2001 13:13:24 -0700")
Message-ID: <d9u20xem8m.fsf@han.cs.umn.edu>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/21.0.103
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sl@whiskey.fireplug.net (Stuart Lynne) writes:
[snip]
> A counter example that does both, bc does tell us who wrote it 
> every time we run it (most annoying) and is smart enough to know
> when it is not talking to a tty.
> 
>     % bc
>     bc 1.05
>     Copyright 1991, 1992, 1993, 1994, 1997, 1998 Free Software Foundation, Inc.
>     This is free software with ABSOLUTELY NO WARRANTY.
>     For details type `warranty'. 
>     1+2
>     3
>     % bc > test
>     1+2
>     % cat test
>     3
>     %

That may be because of clause (2.c) of the GPL version 2.

- Hari
-- 
Raja R Harinath ------------------------------ harinath@cs.umn.edu
"When all else fails, read the instructions."      -- Cahn's Axiom
"Our policy is, when in doubt, do the right thing."   -- Roy L Ash
