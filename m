Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263958AbSJ3ERS>; Tue, 29 Oct 2002 23:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263997AbSJ3ERS>; Tue, 29 Oct 2002 23:17:18 -0500
Received: from employees.nextframe.net ([212.169.100.200]:27901 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S263958AbSJ3ERQ>; Tue, 29 Oct 2002 23:17:16 -0500
Date: Wed, 30 Oct 2002 05:35:20 +0100
From: Morten Helgesen <morten.helgesen@nextframe.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Incorrect 2.5.45 tar-balls created..
Message-ID: <20021030053520.A109@sexything>
Reply-To: morten.helgesen@nextframe.net
References: <Pine.LNX.4.44.0210291957330.1626-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210291957330.1626-100000@home.transmeta.com>
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Chief, 

On Tue, Oct 29, 2002 at 08:03:33PM -0800, Linus Torvalds wrote:
> 
> There was, for a while, bogus 2.5.45 tar-balls etc created from a BK tree
> that was never meant to be exported (translation: "Linus ran his automatic
> release-scripts on a bad tree because he is a booger-head").
> 
> I've removed the offending files, and hopefully nobody even had time to
> download them, but just in case - if you get your kernels as tar-balls (or 
> as old-fashioned patches) rather than from the BK tree, and you saw a 
> 2.5.45, you should ignore it.

hehe - I got it from kernel.org and even sent off a one-liner against 
it to fix an error in net/ipv4/syncookies.c before I saw your mail ...

As I saw Roman`s mail about kernel conf 1.3 ("Update to 2.5.45") I thought
"Cool!" and got 2.5.45.tar.gz right away ... hehe - anyway, no harm done ... 
The image didn`t boot though, so I guess I`ll wait until
you release a _real_ 2.5.45 before doing more testing. 

> 
> 		Linus "booger-head" Torvalds
> 

== Morten

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net
