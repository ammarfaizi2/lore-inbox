Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130013AbRAVXVN>; Mon, 22 Jan 2001 18:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129692AbRAVXVD>; Mon, 22 Jan 2001 18:21:03 -0500
Received: from athena.intergrafix.net ([206.245.154.69]:4878 "HELO
	athena.intergrafix.net") by vger.kernel.org with SMTP
	id <S130794AbRAVXUv>; Mon, 22 Jan 2001 18:20:51 -0500
Date: Mon, 22 Jan 2001 18:20:49 -0500 (EST)
From: Admin Mailing Lists <mlist@intergrafix.net>
To: Larry McVoy <lm@bitmover.com>
Cc: Jonathan Earle <jearle@nortelnetworks.com>,
        "'Linux Kernel List'" <linux-kernel@vger.kernel.org>
Subject: Re: [OT?] Coding Style
In-Reply-To: <20010122082254.D9530@work.bitmover.com>
Message-ID: <Pine.LNX.4.10.10101221817170.12017-100000@athena.intergrafix.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Please don't listen to this.  The only place you really want comments is
> 
>     a) at the top of files, describing the point of the file;
>     b) at the top of functions, if the purpose of the function is not obvious;
>     c) in line, when the code is not obvious.
> 
> If you are writing code that requires a comment for every line, you are 
> writing bad, obscure, unobvious code and no amount of commenting will fix
> it.
> 

or 
1) your code-viewing audience is a bunch of 5 year olds
2) the person reading the code isn't a 'qualified' programmer. If they
   were, they'd most likely be able to understand the code without
   hand-holding of that magnitude. We don't write code for idiots.


-Tony
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.
Anthony J. Biacco                       Network Administrator/Engineer
thelittleprince@asteroid-b612.org       Intergrafix Internet Services

    "Dream as if you'll live forever, live as if you'll die today"
http://www.asteroid-b612.org                http://www.intergrafix.net
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
