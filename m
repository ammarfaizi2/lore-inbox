Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278206AbRJRX3z>; Thu, 18 Oct 2001 19:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278207AbRJRX3q>; Thu, 18 Oct 2001 19:29:46 -0400
Received: from [200.47.148.193] ([200.47.148.193]:60679 "EHLO core.domain")
	by vger.kernel.org with ESMTP id <S278203AbRJRX33>;
	Thu, 18 Oct 2001 19:29:29 -0400
Date: Tue, 16 Oct 2001 14:29:59 -0300
From: martin sepulveda <msepulveda@joydivision.com.ar>
To: linux-kernel@vger.kernel.org
Subject: Re: load 1 at idle, 2.4.12-ac3
Message-Id: <20011016142959.75fd63b9.msepulveda@joydivision.com.ar>
In-Reply-To: <20011018161607.D2467@mikef-linux.matchmail.com>
In-Reply-To: <20011016135322.02ed0f97.martin@joydivision.com.ar>
	<20011016140041.2f26c95c.msepulveda@joydivision.com.ar>
	<20011018161607.D2467@mikef-linux.matchmail.com>
X-Mailer: Sylpheed version 0.6.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux for the whole world
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

what it was? a paused xmms plugin in development (xmms was stoped)

talk about shame :)

M.


On Thu, 18 Oct 2001 16:16:07 -0700
Mike Fedyk <mfedyk@matchmail.com> wrote:

> On Tue, Oct 16, 2001 at 02:00:41PM -0300, martin sepulveda wrote:
> > forget it!
> > i've found what it was, and it is certainly *not* the kernel :)
> > 
> > thanks anyway, and sorry
> > 
> 
> What was it?  A process stuck in D state?  Something like dist.net or seti?
> 
> Reminds me of recently when my X server (a couple days ago from
> debian-unstable) cought a memory leak, and my system was swapping like
> crazy.  I thought it was something to do with the shmem problem I found a
> while back, but I looked at /proc/meminfo and no errors with shmem.  Finally
> I checked top...
> 
> Unfortunately, the OOM killer killed a few things, all except for my X
> server that was causing the problem.
> 
> Mike

-- 
Talent does what it can, genius what it must.
I do what I get paid to do.
