Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285498AbSALPrC>; Sat, 12 Jan 2002 10:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287134AbSALPqs>; Sat, 12 Jan 2002 10:46:48 -0500
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:28584 "EHLO
	falcon.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S285498AbSALPq3>; Sat, 12 Jan 2002 10:46:29 -0500
Date: Sat, 12 Jan 2002 10:50:09 -0500
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 1-2-3 GB
Message-ID: <20020112105009.A6642@earthlink.net>
In-Reply-To: <20020112004528.A159@earthlink.net> <20020112125625.E1482@inspiron.school.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020112125625.E1482@inspiron.school.suse.de>; from andrea@suse.de on Sat, Jan 12, 2002 at 12:56:25PM +0100
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Derived from:
> > htty://kernelnewbies.org/kernels/rh72/SOURCES/linux-2.4.2-vm-1-2-3-gbyte.patch
> > Some parts of the patch above are already in the mainline trees.
> > 
> > Patch below applies to 2.4.18pre2aa2:
> 
> for a fileserver (even more if in kernel like tux) it certainly make
> sense to have as much direct mapped memory as possible, it is not the
> recommended setup for a generic purpose kernel though. So I applied the
> patch (except the prefix thing which is distribution specific). thanks,
> 
> Andrea

Thanks so much!

-- 
Randy Hron

