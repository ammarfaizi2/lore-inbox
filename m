Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264857AbSLGWl6>; Sat, 7 Dec 2002 17:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264863AbSLGWl6>; Sat, 7 Dec 2002 17:41:58 -0500
Received: from packet.digeo.com ([12.110.80.53]:9183 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264857AbSLGWl5>;
	Sat, 7 Dec 2002 17:41:57 -0500
Message-ID: <3DF27AF9.7BA0D1B5@digeo.com>
Date: Sat, 07 Dec 2002 14:49:29 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jorg de Jong <jorg@dejong.info>
CC: linux-kernel@vger.kernel.org
Subject: Re: status of HPT374 support in 2.4.20 and 2.5.50
References: <3DF26772.8040502@dejong.info> <3DF26DF4.F1692AFA@digeo.com> <3DF2759F.1090403@dejong.info>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Dec 2002 22:49:29.0827 (UTC) FILETIME=[E6E01330:01C29E42]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jorg de Jong wrote:
> 
> > This patch (against 2.4.20) is the one I use when I need to
> > use the hpt374 in 2.4 kernels.
> >
> >
> >
> Hi Andrew,
> 
> Thanks for your reply. I tried the patch but it gives a kernel panic
> at file hpt366.c:1344 :-(.
> 

Well, you must have a card which is newer than the driver understands.
That's one for the IDE guys...
