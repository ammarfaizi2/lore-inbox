Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262980AbTC1NtJ>; Fri, 28 Mar 2003 08:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262981AbTC1NtJ>; Fri, 28 Mar 2003 08:49:09 -0500
Received: from polaris.cbu.edu ([66.192.88.32]:65518 "HELO polaris.cbu.edu")
	by vger.kernel.org with SMTP id <S262980AbTC1NtI>;
	Fri, 28 Mar 2003 08:49:08 -0500
From: "wturkal" <wturkal@cbu.edu>
Reply-to: wturkal@cbu.edu
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: LKML <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: [BUG] laptop keyboard, even more info
X-Mailer: Quality Web Email v3.0n, http://netwinsite.com/refw.htm
Date: Fri, 28 Mar 2003 08:00:16 -0600
Message-id: <3e845570.6a96.29952@cbu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



----- Original Message Follows -----
> On Fri, 2003-03-28 at 08:04, Warren Turkal wrote:
> > 2.5.66 still exhibits this bug. It is very strange
> > because I even tried to  compile a 2.5.66 kernel without
> > at keyboard support and it still kill the Fn  key
> functionality, meaning that I cannot make presentations on
> > my laptop  because I cannot switch the video output to
> > the back of the laptop as I was  able to before.
> 
> Are you running XFree86 4.3.0?
> 
Yes, but the bug manifests very shortly after starting the
kernel. I am 99% sure that it happens before init is even
started.
For a split second after the kernel starts, I am still able
to use
the Fn key. Then, all the sudden, I cannot. I am running
Debian
Sid, and I notice the modules loading about when this bug
manifests
itself. Even if I make my modules not load, the bug still
manifests
itself.

Thanks, Warren
