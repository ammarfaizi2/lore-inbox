Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289947AbSAKNTk>; Fri, 11 Jan 2002 08:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289948AbSAKNTZ>; Fri, 11 Jan 2002 08:19:25 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:28164 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S289944AbSAKNTH>;
	Fri, 11 Jan 2002 08:19:07 -0500
Date: Fri, 11 Jan 2002 14:18:50 +0100
From: Jens Axboe <axboe@suse.de>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Big patch: linux-2.5.2-pre11/drivers/scsi compilation fixes
Message-ID: <20020111141850.B19814@suse.de>
In-Reply-To: <20020111051456.A12788@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020111051456.A12788@baldur.yggdrasil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11 2002, Adam J. Richter wrote:
> 	Today I plan to post patches to make everything in
> linux-2.5.2-pre11/drivers/scsi compile, at least everything under
> x86, compiled as modules.  They compile, and, the only undefined
> symbol in when I boot is scsi_mark_host_reset in BusLogic.c.
> However, the 2.5.2-pre11 patches are completely untested.

Please hang on with this for a week or so, there will be other changes
to SCSI drivers required. You'll just end up doing the work twice.

-- 
Jens Axboe

