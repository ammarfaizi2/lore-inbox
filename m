Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269897AbUIDMEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269897AbUIDMEV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 08:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269910AbUIDMEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 08:04:20 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:31951 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S269897AbUIDMES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 08:04:18 -0400
Date: Sat, 4 Sep 2004 13:04:17 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Whitwell <keith@tungstengraphics.com>, Dave Jones <davej@redhat.com>,
       Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
In-Reply-To: <20040904124658.A14628@infradead.org>
Message-ID: <Pine.LNX.4.58.0409041253390.25475@skynet>
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com>
 <Pine.LNX.4.58.0409040145240.25475@skynet> <20040904102914.B13149@infradead.org>
 <41398EBD.2040900@tungstengraphics.com> <20040904104834.B13362@infradead.org>
 <413997A7.9060406@tungstengraphics.com> <20040904112535.A13750@infradead.org>
 <4139995E.5030505@tungstengraphics.com> <20040904112930.GB2785@redhat.com>
 <4139A9F4.4040702@tungstengraphics.com> <20040904124658.A14628@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Even if you are not speaking for Thungesten you pretty much show that
> Thungsten has developers that in an area that overlaps with their works are
> not willing to get things done the kernel way.

I don't know if you anyone can claim the "kernel way" except Linus, if he
decideds our argument is worth it, then it becomes the kernel way as far
as I'm concerned... what you mean is the way things are usually done,
which may not always be applicable in every case,

> This should be a v ery big warnings sign for potentitial Thungsten Customers
> to look for a better supplier or at least give very strong directions.

I've got nothing to do with Tungsten whatsoever, I've never met any of the
other major DRI developers, my worries here is this is turning into a
company issue, people keep mentioning Fedora this and that, Fedora is one
distro, I happen to use it, lots of people I know dont.. it supports DRI
on IGP and i915 in Fedora 3 Test only, a DRI snapshot works on FC1 and
FC2 as well..

>
> And how does taking random dri snapshots help you there?  The only sane way
> to make that happen is to make sure it's in the various distro kernels ASAP.

Again what about distros that only do security upgrades in stable
releases, I would like to give those people a chance to use their graphics
cards, and the snapshots are not the only way, Intel have i915 Linux
drivers on their site from TG, they work on most kernels/distros, I get a
machine with i915 install Debian go to Intels website and download their
drivers, it all works, now why do I have to compile a kernel again?

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

