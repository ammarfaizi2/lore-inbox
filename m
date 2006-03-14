Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWCNASP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWCNASP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 19:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWCNASP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 19:18:15 -0500
Received: from nproxy.gmail.com ([64.233.182.206]:5467 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750941AbWCNASO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 19:18:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MIIbL6bDXm2ajbl62N+M8rccMpaUmYRc1Dh4g5Pp9CAMYfaRIUftHWdlQA2Uqan5jkG8lR8THawj6rsWhLz2T9mbTEQgRntt7z2UbVpMiLvzFEOk7bf1Ifztoi794gDf3V5MHvbI6wvbL7yZ69ENdE9j/Iyu8X/rLa4CTLe3P88=
Message-ID: <436c596f0603131618s1fb4b37bre70d66712a6d29b7@mail.gmail.com>
Date: Mon, 13 Mar 2006 21:18:12 -0300
From: j4K3xBl4sT3r <jakexblaster@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Which kernel is the best for a small linux system?
In-Reply-To: <20060313190109.GC13973@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <436c596f0603121640h4f286d53h9f1dd177fd0475a4@mail.gmail.com>
	 <1142237867.3023.8.camel@laptopd505.fenrus.org>
	 <20060313182725.GA31211@mars.ravnborg.org>
	 <1142275289.13256.1.camel@mindpipe> <20060313190109.GC13973@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/06, Adrian Bunk <bunk@stusta.de> wrote:
> On Mon, Mar 13, 2006 at 01:41:27PM -0500, Lee Revell wrote:
> > On Mon, 2006-03-13 at 19:27 +0100, Sam Ravnborg wrote:
> > > # latencies up to 80% slower
> >
> > This is certainly bullshit, it has not been true since 2.6.7 or so.
> >
> > Did not visit the page but that list smells like they are selling
> > something.
>
> The might be issues already fixed in 2.6.15 (he tested the then-current
> 2.6.11.7) or there might be powerpc specific problems, but after a quick
> look at this page it looks like a serious page.
>
> He also posted the complete lmbench results, dmesg's and .config's at
> his page, and from a first view I'd say he has very well documented
> what and how he measured.
>
> > Lee
>
> cu
> Adrian
>
> --
>
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
>
>

Ye, I just compiled the lastest kernel, 2.6.15.6, it seems a lot
faster than my old one, 2.6.15.4, with the same configuration, and
faster to compile, even I was compiling dietlibc (that incredible got
only 10MB).
