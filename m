Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318714AbSHAJxu>; Thu, 1 Aug 2002 05:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318715AbSHAJxu>; Thu, 1 Aug 2002 05:53:50 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:15750 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318714AbSHAJxp>;
	Thu, 1 Aug 2002 05:53:45 -0400
Date: Thu, 1 Aug 2002 11:57:01 +0200
From: Jens Axboe <axboe@suse.de>
To: martin@dalecki.de
Cc: Greg KH <greg@kroah.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au
Subject: Re: [BK PATCH] devfs cleanups for 2.5.29
Message-ID: <20020801095701.GF1096@suse.de>
References: <20020730225359.GA17826@kroah.com> <3D4848D5.9080208@evision.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D4848D5.9080208@evision.ag>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31 2002, Marcin Dalecki wrote:
> Greg KH wrote:
> >Hi,
> >
> >When devfs came alone, it created devfs_[un]register_chrdev and
> >devfs_[un]register_blkdev, which required that all drivers be changed to
> >be compatible with devfs. This change has been bothering a lot of people
> >for quite some time :)
> 
> Thanks! Finally someone got annoyed enough.

Yeah, let me add a big me too to that statement.

-- 
Jens Axboe

