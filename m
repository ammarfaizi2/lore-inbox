Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281873AbRK1IfR>; Wed, 28 Nov 2001 03:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281815AbRK1IfH>; Wed, 28 Nov 2001 03:35:07 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:56848 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S281873AbRK1Ie6>;
	Wed, 28 Nov 2001 03:34:58 -0500
Date: Wed, 28 Nov 2001 09:34:35 +0100
From: Jens Axboe <axboe@suse.de>
To: David Dyck <dcd@tc.fluke.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops in 2.5.1-pre2
Message-ID: <20011128093435.N23858@suse.de>
In-Reply-To: <Pine.LNX.4.33.0111271708020.4053-100000@dd.tc.fluke.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111271708020.4053-100000@dd.tc.fluke.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27 2001, David Dyck wrote:
> 
> 
> while booting 2.5.1-pre2 I got the following oops

[snip]

please apply

kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.1-pre2/bio-pre2.bz2

and see if that doesn't fix it, thanks.

-- 
Jens Axboe

