Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315779AbSE2Xnw>; Wed, 29 May 2002 19:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315760AbSE2Xnu>; Wed, 29 May 2002 19:43:50 -0400
Received: from [195.63.194.11] ([195.63.194.11]:47626 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315746AbSE2Xnr>; Wed, 29 May 2002 19:43:47 -0400
Message-ID: <3CF55A05.8070100@evision-ventures.com>
Date: Thu, 30 May 2002 00:45:25 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.5.19 - What's up with the kernel build?
In-Reply-To: <Pine.LNX.4.44.0205291519270.9971-100000@chaos.physics.uiowa.edu> <20020529232228.GX5997@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> On Wed, May 29, 2002 at 03:22:52PM -0500, Kai Germaschewski wrote:
> 
> 
>>>>>It's possible with only small changes to provide a quiet mode now,
>>>>>which would not print the entire command lines but only
>>>>>
>>>>>	  Descending into drivers/isdn/kcapi
>>>>>	  Compiling kcapi.o
>>>>>	  Compiling capiutil.o
>>>>>	  Linking kernelcapi.o
>>>>>	  ...
>>>>>
>>>>>Is that considered useful?
>>>>
> 
> I don't think so.  If you're on a slow connection or something, redirect
> stdout to a log and watch stderr.  If you just want something prettier,
> and this is easy, I don't think this is a bad thing.  I don't think it
> should be the default tho either. :)

Or in clear words - it's redundant bullshit if you don't care and
it's preventing you from seeing the "trueth" if you care.
Please just make make -s work agin and I would be happy. OK?

