Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274513AbRJTVnJ>; Sat, 20 Oct 2001 17:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274520AbRJTVm6>; Sat, 20 Oct 2001 17:42:58 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:60155
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S274513AbRJTVmt>; Sat, 20 Oct 2001 17:42:49 -0400
Date: Sat, 20 Oct 2001 14:43:18 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: MichaelM <michail@manegakis.freeserve.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The new X-Kernel !
Message-ID: <20011020144318.C31863@mikef-linux.matchmail.com>
Mail-Followup-To: MichaelM <michail@manegakis.freeserve.co.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <00d401c159ae$6000c7d0$5cbefea9@moya>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00d401c159ae$6000c7d0$5cbefea9@moya>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2001 at 10:30:00PM +0100, MichaelM wrote:
> People need a nice stable Operating System for networking purposes of any
> type, and this exists, Linux of course. What else should the world need?
> 
> People need a nice stable Operating System for Desktop and Multimedia
> purposes and this doesn't exist. We should create a new stable X-Kernel with
> build in support for X. Pressing Alt-F1 a console should pop up.
> 
> Boots up with X, that means.
>

We already have this.  It's called xdm, kdm, or gdm.

> Come on Linus, show the world what you can do, release the X-Kernel 1.01.
> 
> Hit the MS dominar where it hurts, THE DESKTOP.
> 
> Parallel release of Kernel and X-Kernel, will put Linux where it belongs,
> THE TOP of course.
> 

Starting X sooner or later in the boot process won't make Linux any better
or worse than the competition.

What you are asking for is a distribution feature request, not a kernel
feature request.

You can get X to startup sooner by modifying your init scripts.  Just start
?dm after networking, and any other services that X will depend on.  Now you
can have any other services such as nfsd, samba, http, etc in parallel to X.

Mike
