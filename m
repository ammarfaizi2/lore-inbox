Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268290AbTBMVNO>; Thu, 13 Feb 2003 16:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268302AbTBMVNO>; Thu, 13 Feb 2003 16:13:14 -0500
Received: from chaos.analogic.com ([204.178.40.224]:8322 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268290AbTBMVNN>; Thu, 13 Feb 2003 16:13:13 -0500
Date: Thu, 13 Feb 2003 16:25:48 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Paul P Komkoff Jr <i@stingr.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
In-Reply-To: <20030213204518.GC14764@stingr.net>
Message-ID: <Pine.LNX.3.95.1030213161951.15739A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2003, Paul P Komkoff Jr wrote:

> Replying to Linus Torvalds:
> > It's a generic "synchronous signal delivery" method, and it uses a
> > perfectly regular file descriptor to deliver an arbitrary set of signals
> > that are pending.
> 
> The one functionality I miss way too much in linux (comparing to win32) is
> FindFirstChangeNotification and ReadDirectoryChangesW thing.
> 

But they are __not__ kernel functions!  They are part of the "window"
(basically a shell). All the stuff necessary to implement that
on a Unix/Linux system already exists, and has existed since the
birth of Unix, circa 1970.

... and if it were necessary to be implemented, it
       WouldNeverHaveSuchAGoddamnLongFunctionName(ever);


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


