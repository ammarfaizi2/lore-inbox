Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316022AbSEJPS5>; Fri, 10 May 2002 11:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316023AbSEJPS4>; Fri, 10 May 2002 11:18:56 -0400
Received: from air-2.osdl.org ([65.201.151.6]:4615 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S316022AbSEJPSz>;
	Fri, 10 May 2002 11:18:55 -0400
Date: Fri, 10 May 2002 08:18:18 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Russell King <rmk@arm.linux.org.uk>
cc: Chris Friesen <cfriesen@nortelnetworks.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: how to redirect serial console to telnet session?
In-Reply-To: <20020510160945.B7165@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.33L2.0205100817430.6809-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2002, Russell King wrote:

| On Fri, May 10, 2002 at 09:05:41AM -0400, Chris Friesen wrote:
| > Accordingly, I grabbed what looked like the important bits of xconsole, but it
| > appears that this only gets me stuff written to /dev/console from userspace.
| > How do I go about getting the output of kernel-level printk()s as well?
|
| Check the LKML archives for something called 'netconsole' (or use google).
| It got mentioned here about 6 months to a year ago.

It's in http://people.redhat.com/mingo/netconsole-patches/ (for 2.4.10).

-- 
~Randy

