Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313189AbSEIOiu>; Thu, 9 May 2002 10:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313194AbSEIOit>; Thu, 9 May 2002 10:38:49 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:47121 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313189AbSEIOiq>; Thu, 9 May 2002 10:38:46 -0400
Date: Thu, 9 May 2002 10:35:28 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: strange things in kernel 2.4.19-pre7-ac4 + preempt patch
In-Reply-To: <20020509113524.86374.qmail@web10407.mail.yahoo.com>
Message-ID: <Pine.LNX.3.96.1020509103433.7914D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2002, [iso-8859-1] Steve Kieu wrote:

> I am running 2.4.19-pre7-ac4 , Mandrake 8.1 and
> noticed  strange thing ..
> 
>   If I logout from Xsesion, I can not see any vc ; no
> command line, etc...; all I have is a blank screen.
> Try tp type a command like  sudo  halt  to turn off
> the computer, no response. But can use Ctrl + Alt +
> Del to cleanly reboot the machine
> 
> What is the cause? thanks for your time

Alt-Cntl-F1 will get you to a console out of X. The X server seems still
running.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

