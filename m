Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbWARRdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWARRdD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 12:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWARRdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 12:33:03 -0500
Received: from xenotime.net ([66.160.160.81]:41609 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751406AbWARRdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 12:33:02 -0500
Date: Wed, 18 Jan 2006 09:32:58 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: "Brian D. McGrew" <brian@visionpro.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Unknown Symbols in drivers
In-Reply-To: <14CFC56C96D8554AA0B8969DB825FEA09709FE@chicken.machinevisionproducts.com>
Message-ID: <Pine.LNX.4.58.0601180931320.28417@shark.he.net>
References: <14CFC56C96D8554AA0B8969DB825FEA09709FE@chicken.machinevisionproducts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2006, Brian D. McGrew wrote:

> Good morning,
>
> I've compiled up several different versions of the kernel for a Dell
> 1800 and a Dell 1600 and I keep seeing many many errors of "Unknown
> Symbol" in the drivers ata_piix, mtpscsibase and mptscsih.  What am I
> missing here?  Is this a compiler problem or am I doing something
> wrong???

Not likely a compiler problem.

We need to see the complete kernel messages when this happens.
That will tell what symbol(s) are missing.

Also what kernel version you are building.
Is it a distro kernel or one that you downloaded from kernel.org?

-- 
~Randy
