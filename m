Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286723AbRLVIdg>; Sat, 22 Dec 2001 03:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286724AbRLVId0>; Sat, 22 Dec 2001 03:33:26 -0500
Received: from bwbohh.net ([66.96.192.22]:59014 "EHLO garcia.hostnoc.net")
	by vger.kernel.org with ESMTP id <S286723AbRLVIdR>;
	Sat, 22 Dec 2001 03:33:17 -0500
Date: Sat, 22 Dec 2001 03:33:34 -0500
From: Eric Windisch <ericw@grokthis.net>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help editorial policy
Message-ID: <20011222033334.B25321@grokthis.net>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011220143247.A19377@thyrsus.com> <3C2310A4.1010004@purplet.demon.co.uk> <20011222082444.EXOZ22539.femail25.sdc1.sfba.home.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011222082444.EXOZ22539.femail25.sdc1.sfba.home.com@there>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2001 at 07:23:13PM -0500, Rob Landley wrote:
> 
> This may be why Andrea Arcangelli refuses to write any documentation at all, 
> Linus seems to have a prediliction for dropping documentation-only patches, 
> why the stuff in /linux/documentation has fallen up to two years out of date 
> at times, and why "Rusty's Unreliable Guides" (the best source of 
> documentation on the netfilter code, made available by the author himself at 
> "http://netfilter.samba.org/unreliable-guides/") says, and I quote:
> 

No doubt. The file drivers/block/loop.c has about 21 comments, although most of them are useless. The file is over 1700 lines long.

It would be a lot easier to grok this code if it didn't look like an entry for the IOCCC :) Comments would be nice.

--
Eric Windisch
http://bwbohh.net
