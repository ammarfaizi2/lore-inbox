Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130356AbRCBIp6>; Fri, 2 Mar 2001 03:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130368AbRCBIpt>; Fri, 2 Mar 2001 03:45:49 -0500
Received: from mgw-x4.nokia.com ([131.228.20.27]:22013 "EHLO mgw-x4.nokia.com")
	by vger.kernel.org with ESMTP id <S130356AbRCBIpc>;
	Fri, 2 Mar 2001 03:45:32 -0500
Date: Fri, 2 Mar 2001 10:44:58 +0200 (EET)
From: Matilainen Panu <panu.matilainen@nokia.com>
To: ext Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.x very unstable on 8-way IBM 8500R
In-Reply-To: <E14YeT4-0000ej-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0103021042360.984-100000@hed042-209.research.nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Mar 2001, ext Alan Cox wrote:

> > > (from Red Hat 7) but very erratic on all 2.4-kernels I've tried it with
> > > (2.4.[012], compiled both with egcs and RH7's gcc-2.96, both share the
>                                    ^^^^
>
> > Under redhat 7 you should use kgcc to compile the kernel, since gcc2.96 is
>
> So he was using egcs, and whether he had the pre-errata gcc 2.96
> wouldnt matter

Since this (once again) came up... I've been running 2.4.[012] on my home
box compiled with 2.96-errata without a single problem so far.

And yes I know it's not supported, consider this just a datapoint :)

	- Panu -

>

