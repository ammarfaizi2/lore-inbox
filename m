Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316643AbSE3NtC>; Thu, 30 May 2002 09:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316644AbSE3NtB>; Thu, 30 May 2002 09:49:01 -0400
Received: from [195.63.194.11] ([195.63.194.11]:5135 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S316643AbSE3NtB>;
	Thu, 30 May 2002 09:49:01 -0400
Message-ID: <3CF62020.2030704@evision-ventures.com>
Date: Thu, 30 May 2002 14:50:40 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Keith Owens <kaos@ocs.com.au>
Subject: Re: KBuild 2.5 Impressions
In-Reply-To: <E17DMUd-0007dJ-00@starship>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

> Along the way, old kbuild did the usual wrong things:
> 
>   - In the incremental build, 6 files rebuilt that should not have been
> 
>   - Once, when I interrupted the make dep, subsequent make deps would
>     no longer work, forcing me to do make mrproper and start again.
> 
>   - Way too much output to the screen

Bull shit: make -s helps.

