Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315285AbSEaNec>; Fri, 31 May 2002 09:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315293AbSEaNeb>; Fri, 31 May 2002 09:34:31 -0400
Received: from carbon.btinternet.com ([194.73.73.92]:63205 "EHLO carbon")
	by vger.kernel.org with ESMTP id <S315285AbSEaNe3>;
	Fri, 31 May 2002 09:34:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nick Sanders <sandersn@btinternet.com>
To: Paul P Komkoff Jr <i@stingr.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] kbuild-2.5 for 2.4.19-pre9-ac{2,3}
Date: Fri, 31 May 2002 14:37:02 +0100
User-Agent: KMail/1.4.1
In-Reply-To: <20020531081855.GE355@stingr.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200205311437.02219.sandersn@btinternet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 May 2002 9:18 am, Paul P Komkoff Jr wrote:
> Untested.
>
> http://stingr.net/l/kbuild25-for-2.4.19-pre9-ac2.bz2
> http://stingr.net/l/kbuild25-for-2.4.19-pre9-ac3.bz2
>
> -or-
>
> ftp://stingr.net/pub/l/kbuild25-for-2.4.19-pre9-ac2.bz2
> ftp://stingr.net/pub/l/kbuild25-for-2.4.19-pre9-ac3.bz2

There is a slight problem if you have 'Processor Family' set to k6 or k7 you 
can't install the kernel (I used kbuild25-for-2.4.19-pre9-ac3.bz2).
This is an old error that has somehow crept back in.

See - http://marc.theaimsgroup.com/?l=linux-kernel&m=102041607029461&w=2

This fixes it.

Nick
