Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288801AbSBIJfs>; Sat, 9 Feb 2002 04:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288800AbSBIJf3>; Sat, 9 Feb 2002 04:35:29 -0500
Received: from femail47.sdc1.sfba.home.com ([24.254.60.41]:25303 "EHLO
	femail47.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S288788AbSBIJfV>; Sat, 9 Feb 2002 04:35:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Andrew Morton <akpm@zip.com.au>, Larry McVoy <lm@bitmover.com>
Subject: Re: [bk patch] Make cardbus compile in -pre4
Date: Sat, 9 Feb 2002 04:36:14 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0202081824070.25114-100000@segfault.osdlab.org> <20020208211257.F25595@work.bitmover.com> <3C64B451.3BC4B0CE@zip.com.au>
In-Reply-To: <3C64B451.3BC4B0CE@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020209093520.XVXR9607.femail47.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 February 2002 12:32 am, Andrew Morton wrote:
> Larry McVoy wrote:
> > For one, he seems to like that model,
>
> Well I don't.  I'd like to see as many kernel changes as possible
> sent to this mailing list, as unified diffs, with an explanation.

I personally hope one of the patchbot projects (patches-only lists, 
filtered/moderated) gets mature enough to use soon.

Optimizing the bandwidth of Linus and optimizing for the rest of the 
developer community are two seperate problems which may require two seperate 
toolchains.  Posting a patch to the list already isn't enough to get it to 
Linus.  Hasn't been for a while...

Rob
