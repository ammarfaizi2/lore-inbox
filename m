Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272036AbRHVPwm>; Wed, 22 Aug 2001 11:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272034AbRHVPwc>; Wed, 22 Aug 2001 11:52:32 -0400
Received: from athena.intergrafix.net ([206.245.154.69]:49280 "HELO
	athena.intergrafix.net") by vger.kernel.org with SMTP
	id <S272036AbRHVPw1>; Wed, 22 Aug 2001 11:52:27 -0400
Date: Wed, 22 Aug 2001 11:52:42 -0400 (EDT)
From: Admin Mailing Lists <mlist@intergrafix.net>
To: Travis Shirk <travis@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Locking Up
In-Reply-To: <Pine.LNX.4.33.0108220938390.1152-100000@puddy.travisshirk.net>
Message-ID: <Pine.LNX.4.10.10108221151220.1046-100000@athena.intergrafix.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1) re-direct console messages to a serial port
2) don't run a GUI for a while (so you can see console messages)

-Tony
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.
Anthony J. Biacco                       Network Administrator/Engineer
thelittleprince@asteroid-b612.org       Intergrafix Internet Services

    "Dream as if you'll live forever, live as if you'll die today"
http://www.asteroid-b612.org                http://www.intergrafix.net
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.

On Wed, 22 Aug 2001, Travis Shirk wrote:

> Hello,
> 
> Ever since I upgraded to the 2.4.x (currently running 2.4.8)
> kernels, my machine has been locking up every other day
> or so.  Does anyone have any hints/tips for figuring out
> what is going on.
> 
> The symptons are total lock-up of the machine.  No mouse
> movement, all GUI monoitors freeze, and I cannot switch to a
> virtual console.  I'm not able to ping the locked machine or
> ssh/telnet into it either.  So I'm left wondering....how and
> the hell to I debug this problem.  It'd be nice to have some
> more information to go on or post to the list.
> 
> I'm running on a dual PIII 850, and this problem occurs with
> 2.4.7 and 2.4.8.
> 
> Any suggestions?
> 
> Travis
> 
> -- 
> Travis Shirk <travis at pobox dot com>
> Mathematics is God and Knuth is our prophet.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

