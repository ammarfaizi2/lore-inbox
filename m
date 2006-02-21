Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161231AbWBUXuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161231AbWBUXuO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 18:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161237AbWBUXuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 18:50:13 -0500
Received: from xenotime.net ([66.160.160.81]:65476 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161132AbWBUXuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 18:50:11 -0500
Date: Tue, 21 Feb 2006 15:50:10 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Mark Lord <lkml@rtr.ca>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, linux-acpi@vger.kernel.org
Subject: Re: 2.6.16-rc[34]: resume-from-RAM unreliable
In-Reply-To: <43FBA6AF.3070207@rtr.ca>
Message-ID: <Pine.LNX.4.58.0602211548590.8603@shark.he.net>
References: <43F9D3CA.1010709@rtr.ca> <20060220210943.7f159749.akpm@osdl.org>
 <43FBA6AF.3070207@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2006, Mark Lord wrote:

> Andrew Morton wrote:
> > Mark Lord <lkml@rtr.ca> wrote:
> >> For the past week, I've been trying to keep with the latest -rc*-git*
> >> releases of 2.6.16 on my notebook, and something new in those is
> >> impacting resume-from-RAM.
>
> Mmm.. working 100% now with Randy Dunlop's ACPI additions from here:
>
>      http://www.xenotime.net/linux/SATA/2.6.16-rc3/
>
> Note that these are the latest evolution from a simpler patch by Jens
> which I first started using in *spring 2005* to get suspend/resume working.
>
> Are we *ever* going to add these to mainstream?
> It's been almost a friggin' year!
>
> Cheers

Yes, I understand (I think).  Fortunately I haven't been working
on it quite that long.

I'm updating the patchset to 2.6.16-rc4 and then I'll post it,
probably tomorrow.

-- 
~Randy
