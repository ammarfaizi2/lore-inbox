Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289957AbSAWSQU>; Wed, 23 Jan 2002 13:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289956AbSAWSQK>; Wed, 23 Jan 2002 13:16:10 -0500
Received: from svr3.applink.net ([206.50.88.3]:65296 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S289955AbSAWSP5>;
	Wed, 23 Jan 2002 13:15:57 -0500
Message-Id: <200201231813.g0NID5r15047@home.ashavan.org.>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Daniel Nofftz <nofftz@castor.uni-trier.de>,
        Timothy Covell <timothy.covell@ashavan.org>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
Date: Thu, 24 Jan 2002 12:14:50 -0600
X-Mailer: KMail [version 1.3.2]
Cc: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Dave Jones <davej@suse.de>, Andreas Jaeger <aj@suse.de>,
        Martin Peters <mpet@bigfoot.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0201230814310.29728-100000@infcip10.uni-trier.de>
In-Reply-To: <Pine.LNX.4.40.0201230814310.29728-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]
>
> 2. power safing is a realy good idea generally !
[snip]


Hey, don't get me wrong.  I'm all for power-saving.  That's
why I own a Via C3 based system.   The Via C3 works
great as an NFS server and draws 12 Watts max (avg.
is 6 watts).   For just email and web browsing, I'd definitely
recommend it.   I'd also recommend it for a small firewall/router
system.   However, for A/V apps and heavy compiling, it's
definitely not the way to go [BeOS C3 can handle one
A/V app at a time, but not several].


If the patch is really the way to go, then we should get it
put into the main distribution.  But if it is going to hurt
my performance, then I'd be happy to stick with vanilla
kapmd (hlt based) power saving.

-- 
timothy.covell@ashavan.org.
