Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276646AbSIVGvs>; Sun, 22 Sep 2002 02:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276702AbSIVGvs>; Sun, 22 Sep 2002 02:51:48 -0400
Received: from mail.nls.ac.in ([202.54.87.180]:64773 "EHLO mail.nls.ac.in")
	by vger.kernel.org with ESMTP id <S276646AbSIVGvr>;
	Sun, 22 Sep 2002 02:51:47 -0400
Subject: Re: make bzImage fails on 2.5.38
From: Aniruddha Shankar <ashankar@nls.ac.in>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0209220229480.22740-100000@weyl.math.psu.edu>
References: <Pine.GSO.4.21.0209220229480.22740-100000@weyl.math.psu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 22 Sep 2002 12:26:55 +0530
Message-Id: <1032677815.31536.13.camel@twentyfive.complab>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-22 at 12:01, Alexander Viro wrote:

> 
> 
> On Sun, 22 Sep 2002, Aniruddha Shankar wrote:
> 
> > First post to the list, I've followed the format given in REPORTING-BUGS
> > 
> > 1. make bzImage fails on 2.5.38
> 
> Arrgh.
> 
> ed fs/partitions/check.c <<EOF
> 365s/devfs_handle/cdroms/
> w
> q
> EOF

it's compiling past that point, thanks. .. First time I've had to use ed
*grin* 

Aniruddha shankar
Bangalore, india 
 


