Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277012AbRKZJYN>; Mon, 26 Nov 2001 04:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280744AbRKZJYD>; Mon, 26 Nov 2001 04:24:03 -0500
Received: from [213.237.118.153] ([213.237.118.153]:60544 "EHLO Princess")
	by vger.kernel.org with ESMTP id <S277012AbRKZJX4>;
	Mon, 26 Nov 2001 04:23:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: Allan Sandfeld <linux@sneulv.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel Releases
Date: Mon, 26 Nov 2001 10:22:36 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <4.3.2.7.2.20011124231412.00b40c50@mail.osagesoftware.com>
In-Reply-To: <4.3.2.7.2.20011124231412.00b40c50@mail.osagesoftware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E168HyH-0000xw-00@Princess>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 25 November 2001 05:27, David Relson wrote:

<snip>
> When the kernel maintainer, now Marcelo for 2.4, is ready to release the
> next kernel, for example 2.4.16, I suggest he switch from "pre?" to "-rc1"
> (as in release candidate).  A day or two with -rc1 will quickly show if it
> has a show stopper.  If so, then the minor fixes (and nothing else) go into
> -rc2.  A day or two ..., and either -rc3 appears or we have a stable
> release and 2.4.16 is ready to be released.

Like Linus said, it's a statistical problem: An unofficial kernel would never 
get the same attention as a released one. We would keep seeing problems arise 
once the kernel has been released. 

One thing we could do, was to do the same as the vendors do, and maintain a 
-post kernel with the most glaring bug-fixed, especially build-ones. 

The need to do it however is not that big..
