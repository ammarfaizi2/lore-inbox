Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289179AbSAMM75>; Sun, 13 Jan 2002 07:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289177AbSAMM7p>; Sun, 13 Jan 2002 07:59:45 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53509 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S289174AbSAMM7g>;
	Sun, 13 Jan 2002 07:59:36 -0500
Date: Sun, 13 Jan 2002 13:59:27 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BIO Usage Error or Conflicting Designs
Message-ID: <20020113135927.A11793@suse.de>
In-Reply-To: <20020112210538.F19814@suse.de> <Pine.LNX.4.10.10201121714370.13034-200000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10201121714370.13034-200000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12 2002, Andre Hedrick wrote:
> 
> Jens,
> 
> Here is back at you sir.

Without highmem debug enabled?? I already knew this was the bug
triggered, nothing new here.

Please print the two pfn values triggering the BUG_ON, I'll take a look
at this tomorrow.

-- 
Jens Axboe

