Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287681AbSBKJ4T>; Mon, 11 Feb 2002 04:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287710AbSBKJ4J>; Mon, 11 Feb 2002 04:56:09 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54024 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S287681AbSBKJ4B>;
	Mon, 11 Feb 2002 04:56:01 -0500
Date: Mon, 11 Feb 2002 10:49:17 +0100
From: Jens Axboe <axboe@suse.de>
To: reddog83 <reddog83@chartermi.net>
Cc: davej@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.3-dj5 synclink.c fix so that it compiles
Message-ID: <20020211104917.B1014@suse.de>
In-Reply-To: <auto-000058815980@front2.chartermi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auto-000058815980@front2.chartermi.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11 2002, reddog83 wrote:
> This is a temp fix for thje synclink.c file in drivers/char it work's for me 
> so DJ will you please apply this patch.
> Thank you Victor Torres.
> All it does it removes the #error please convert me to 
> Documentation/DMA-mapping.txt 
> it compiles and work's great for me.

I find this _really_ hard to believe. It may compile, but does it link?

> Please apply

Not really

-- 
Jens Axboe

