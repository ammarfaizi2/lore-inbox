Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267407AbSLETrH>; Thu, 5 Dec 2002 14:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267413AbSLETrG>; Thu, 5 Dec 2002 14:47:06 -0500
Received: from dux1.tcd.ie ([134.226.1.23]:30701 "HELO dux1.tcd.ie")
	by vger.kernel.org with SMTP id <S267407AbSLETqJ> convert rfc822-to-8bit;
	Thu, 5 Dec 2002 14:46:09 -0500
Content-Type: text/plain; charset=US-ASCII
From: Shane Helms <shanehelms@eircom.net>
To: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
Subject: Re: is KERNEL developement finished, yet ???
Date: Thu, 5 Dec 2002 19:52:25 +0000
User-Agent: KMail/1.4.3
References: <200212051224.50317.shanehelms@eircom.net> <000901c29c5d$6d194760$2e833841@joe> <aso4kq$2ka$1@penguin.transmeta.com>
In-Reply-To: <aso4kq$2ka$1@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212051952.25772.shanehelms@eircom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 December 2002 18:07, Linus Torvalds wrote:
> In article <000901c29c5d$6d194760$2e833841@joe>,
>
> Joseph D. Wagner <wagnerjd@prodigy.net> wrote:
> >Unix (and Linux) developers are far too concerned with clinging to the
> >30-year-old outdated POSIX standard, which creates numerous problems when
> >trying to advance new features.
>
> No.
>
> Only stupid people think they should throw away old proven concepts.
> What happens quite often in academia in particular is that you find a
> problem you want to fix, and you re-design the whole system around your
> fix.

Being curious, I was wondering, since we're not changing much in kernel core, 
and developement implies adding additional code and layers for security, 
enhancements and support for further hardware and etc.
Does this not slow down the kernel ? or is the execution code still the same 
??
How does kernel optimization take place ? does it take place at all ??

I can hardly see optimization taking place, if one doesn't modify the old 
code, and chunks of kernel.

Shane
