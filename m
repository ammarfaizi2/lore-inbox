Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280982AbRKGVKb>; Wed, 7 Nov 2001 16:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280985AbRKGVKW>; Wed, 7 Nov 2001 16:10:22 -0500
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:49927 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S280983AbRKGVKJ>; Wed, 7 Nov 2001 16:10:09 -0500
Date: Tue, 6 Nov 2001 10:01:54 +0000
From: Pavel Machek <pavel@suse.cz>
To: Riley Williams <rhw@MemAlpha.cx>
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
Message-ID: <20011106100153.B35@toy.ucw.cz>
In-Reply-To: <506556532.1004787679@[195.224.237.69]> <Pine.LNX.4.21.0111031813390.9415-100000@Consulate.UFP.CX>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0111031813390.9415-100000@Consulate.UFP.CX>; from rhw@MemAlpha.cx on Sat, Nov 03, 2001 at 06:35:44PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>  3. AFAICT, if xntpd writes to the RTC, then it has achieved true
> >>     synchronisation to a reference clock other than the RTC.
> 
> > I thought the original poster was claiming that the /kernel/
> > wrote to the RTC, which would explain the behaviour I'm seeing.
> 
> The kernel itself never writes to the RTC, and that is one of Linus's
> decisions with which I am in 100% agreeance (and one thing I hate about
> Windows). In fact, the kernel itself also doesn't read from the RTC
> either, but leaves that to userspace.

Wrong two times.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

