Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262415AbSKHVO1>; Fri, 8 Nov 2002 16:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262448AbSKHVO1>; Fri, 8 Nov 2002 16:14:27 -0500
Received: from packet.digeo.com ([12.110.80.53]:13974 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262415AbSKHVO0>;
	Fri, 8 Nov 2002 16:14:26 -0500
Message-ID: <3DCC2ABE.5DDE9882@digeo.com>
Date: Fri, 08 Nov 2002 13:21:02 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: alan@cotse.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 2.5.46-mm1 with contest
References: <3DCB09C3.1EDB05EC@digeo.com> <YWxhbg==.c9df84d7e2f29ab2ae921b8f68e36b67@1036789710.cotse.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Nov 2002 21:21:02.0393 (UTC) FILETIME=[BD6B2A90:01C2876C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Willis wrote:
> 
>   Ok, it just happened again.

That's good.

> I'll go upgrade my procps so I have a working vmstat for you next time,
> sorry about that.  Whose shall I use? (riel/rml or calahan, or both?)

Either should do.  The surriel.com/procps one is presumably more
redhatty, but whatever.  Also, run top and see if something is burning
CPU.  /proc/meminfo, /proc/slabinfo, all that stuff.  The clues will
be in there somewhere - it's a matter of hunting around...
