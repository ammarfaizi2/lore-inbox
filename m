Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbTENThS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 15:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbTENThR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 15:37:17 -0400
Received: from smtp1.libero.it ([193.70.192.51]:36797 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id S261241AbTENThQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 15:37:16 -0400
Date: Wed, 14 May 2003 21:49:20 +0300
From: Daniele Pala <dandario@libero.it>
To: Ahmed Masud <masud@googgun.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Core Dump Report
Message-ID: <20030514184920.GA390@libero.it>
References: <NHBBIPBFKBJLCPPIPIBCIEGFCAAA.chandrasekhar.nagaraj@patni.com> <Pine.LNX.4.33.0305140815050.10993-100000@marauder.googgun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0305140815050.10993-100000@marauder.googgun.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 08:16:11AM -0400, Ahmed Masud wrote:
> 
> 
> On Wed, 14 May 2003, Chandrasekhar wrote:
> 
> > Hi Experts,
> >
> > I want to obtain the core dump information from the running kernel.
> > How can I do so by reading the /proc/kcore file.?
> >
> > Regards
> > Chandrasekhar
> > -
> >
> 
> For all intents and purposes you can treat /proc/kcore as a coredump file
> :) . Have a look at kgdb and related tools to interpret it correctly.
> 

yeah, except that /proc/kcore is "dynamic" so you can't always trust the gdb cached information.

> Cheers,
> 
> Ahmed.
>

Cheers,
	
	Daniele 

