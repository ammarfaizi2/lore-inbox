Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284020AbRLROyY>; Tue, 18 Dec 2001 09:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284163AbRLROyP>; Tue, 18 Dec 2001 09:54:15 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:15634 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S284010AbRLROyD>;
	Tue, 18 Dec 2001 09:54:03 -0500
Date: Tue, 18 Dec 2001 15:53:57 +0100
From: Jens Axboe <axboe@suse.de>
To: Hans-Otto Ahl <Hans-Otto.Ahl@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug in 2.5.1
Message-ID: <20011218155357.G32511@suse.de>
In-Reply-To: <8A43C34093B3D5119F7D0004AC56F4BCC3441C@difpst1a.dif.dk> <3C1F305C.9030702@t-online.de> <3C1F5311.2070407@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C1F5311.2070407@t-online.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18 2001, Hans-Otto Ahl wrote:
> Hans-Otto Ahl wrote:
> 
> >Jesper Juhl wrote:
> >
> > >  > Hi chaps, sorry to inform you about a problem in 'ide-floppy' drivers
> > >  > and in the module as well.

Apply this patch

*.kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.1/bio-251-1.bz2

and ide-floppy should work again.

-- 
Jens Axboe

