Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263031AbRF0UJZ>; Wed, 27 Jun 2001 16:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262568AbRF0UJP>; Wed, 27 Jun 2001 16:09:15 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:15114 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263031AbRF0UJK>;
	Wed, 27 Jun 2001 16:09:10 -0400
Date: Wed, 27 Jun 2001 22:09:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: "Jeffrey W. Baker" <jwbaker@acm.org>, linux-kernel@vger.kernel.org
Subject: Re: How to change DVD-ROM speed?
Message-ID: <20010627220909.M17905@suse.de>
In-Reply-To: <200106271938.OAA78951@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200106271938.OAA78951@tomcat.admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27 2001, Jesse Pollard wrote:
> > Excellent. I'd say use the same ioctl if you can, but default to using
> > SET_STREAMING for DVD drives.
> 
> As long as it still works for the combo drives - CD/CD-RW/DVD
> Sony VIAO high end laptops, Toshiba has one, maybe others by now.

As long as it has the DVD features, SET_STREAMING must be supported. So
provided that the combos adhere to that part of the spec (ha), it will
work.

-- 
Jens Axboe

