Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbWBVAmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbWBVAmr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 19:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbWBVAmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 19:42:47 -0500
Received: from xenotime.net ([66.160.160.81]:13990 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030222AbWBVAmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 19:42:47 -0500
Date: Tue, 21 Feb 2006 16:42:45 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Nigel Cunningham <ncunningham@cyclades.com>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Jens Axboe <axboe@suse.de>,
       Ariel Garcia <garcia@iwr.fzk.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc4 libata + AHCI patched for suspend fails on ICH6
In-Reply-To: <200602221037.49604.ncunningham@cyclades.com>
Message-ID: <Pine.LNX.4.58.0602211642090.12588@shark.he.net>
References: <200602191958.38219.garcia@iwr.fzk.de> <20060219191859.GJ8852@suse.de>
 <Pine.LNX.4.58.0602210903260.8603@shark.he.net> <200602221037.49604.ncunningham@cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2006, Nigel Cunningham wrote:

> Hi Randy et al.
>
> On Wednesday 22 February 2006 03:04, Randy.Dunlap wrote:
> > These patches (for 2.6.16-rc3) are at
> > http://www.xenotime.net/linux/SATA/2.6.16-rc3/libata-rollup-2616-rc3.patch
>
> Randy, do you mind if I start including this in the suspend2 patch? I'm
> starting to see more and more people who could probably use this.

I don't mind....

-- 
~Randy
