Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317895AbSFNMLL>; Fri, 14 Jun 2002 08:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317907AbSFNMLK>; Fri, 14 Jun 2002 08:11:10 -0400
Received: from babel.spoiled.org ([217.13.197.48]:3621 "HELO a.mx.spoiled.org")
	by vger.kernel.org with SMTP id <S317895AbSFNMLJ>;
	Fri, 14 Jun 2002 08:11:09 -0400
From: Juri Haberland <juri@koschikode.com>
To: gibbs@scsiguy.com ("Justin T. Gibbs")
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aic7xxx won't compile w/o PCI at all <- fixed
X-Newsgroups: spoiled.linux.kernel
In-Reply-To: <200206132027.g5DKR4968416@aslan.scsiguy.com>
User-Agent: tin/1.4.5-20010409 ("One More Nightmare") (UNIX) (OpenBSD/2.9 (i386))
Message-Id: <20020614121109.B286C11966@a.mx.spoiled.org>
Date: Fri, 14 Jun 2002 14:11:09 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200206132027.g5DKR4968416@aslan.scsiguy.com> you wrote:
>>I know I shouldn't do that
>>I also know someone should do at least compile on cases which affected by
>>some patch.
> 
> I guess I'm missing some context here.
> 
> The patch, on first inspection, appears correct.  Unfortunately, finding
> machines without PCI busses is getting more and more difficult every day,
> but I'll add a build case that disables PCI busses so we catch these kinds
> of failures in the future..

Yes, I noticed this problem also on my 486 with an Adaptec VL host
adapter.

Willing to test any new version ;)

Cheers,
Juri

-- 
Juri Haberland  <juri@koschikode.com> 

