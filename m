Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286942AbSBGJkg>; Thu, 7 Feb 2002 04:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286962AbSBGJkU>; Thu, 7 Feb 2002 04:40:20 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:11278 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S286942AbSBGJkN>;
	Thu, 7 Feb 2002 04:40:13 -0500
Date: Thu, 7 Feb 2002 10:39:10 +0100
From: Jens Axboe <axboe@suse.de>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide-scsi + sg scatterlist fixup
Message-ID: <20020207103910.C731@suse.de>
In-Reply-To: <20020207101624.G16105@suse.de> <Pine.LNX.4.44.0202071128550.3592-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0202071128550.3592-100000@netfinity.realnet.co.sz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07 2002, Zwane Mwaikambo wrote:
> On Thu, 7 Feb 2002, Jens Axboe wrote:
> 
> > Following is a patch to make ide-scsi and sg work again. Of course
> > people can just bk pull the latest changes by now...
> 
> Would this patch allow the box to recover somewhat after an idiot (namely 
> me) does an hdparm -w /dev/hdX on srY?

It shouldn't have any effect on that, no. I've yet to closely read your
report on this...

-- 
Jens Axboe

