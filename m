Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281707AbRLAVjW>; Sat, 1 Dec 2001 16:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281715AbRLAVjN>; Sat, 1 Dec 2001 16:39:13 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:22151 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S281726AbRLAVi4>;
	Sat, 1 Dec 2001 16:38:56 -0500
Date: Sat, 1 Dec 2001 22:38:05 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Gianni Tedesco <gianni@ecsc.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Security issues in 2.4.9 and beyond
In-Reply-To: <1007238127.2475.0.camel@lemsip>
Message-ID: <Pine.LNX.4.21.0112012237350.13986-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Dec 2001, Gianni Tedesco wrote:

> Hi guys,
> 
> I am putting together a database of errata for Linux 2.4.x. It will have
> individual patches for each major bug (at the moment thats just security
> flaws) and a mega-patch for each version. I am starting on kernel 2.4.9
> for no other reason as this is what I currently use...
> 
> This is what I have so far for 2.4.9:
> 1. Netfilter mac address matching bug
> 2. ptrace race condition
> 3. symlink DoS
> 4. syncookie/netfilter bug
> 5. Netfilter FTP conntrack bug (can someone confirm this ??)

#5 was fixed in 2.4.5 I believe.

/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.

