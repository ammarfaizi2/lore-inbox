Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315260AbSE2NZw>; Wed, 29 May 2002 09:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315264AbSE2NZv>; Wed, 29 May 2002 09:25:51 -0400
Received: from ftp.nfas.org.sz ([196.28.7.66]:50338 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S315260AbSE2NZu>; Wed, 29 May 2002 09:25:50 -0400
Date: Wed, 29 May 2002 14:58:32 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.18 IDE 73
In-Reply-To: <3CF4C55F.2030300@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0205291453230.19359-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcin,
	Just a few comments, please don't mistake it for nitpicking, but 
perhaps a request for clarification.

On Wed, 29 May 2002, Martin Dalecki wrote:

> - Don't allow check_partition to be more clever then the writer of a driver.
>    It was interfering with drivers which check partitions as they go and
>    finally if we want to spew something about it - we can do it ourself.

Should this really be the case? Isn't the driver the one that is 
interfering in this case?

>    Anyway we grok the partitions now one by one as we detect the channels.

Same as above.

Thanks,
	Zwane Mwaikambo

-- 
http://function.linuxpower.ca
		

