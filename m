Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314553AbSEKFZd>; Sat, 11 May 2002 01:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314578AbSEKFZc>; Sat, 11 May 2002 01:25:32 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:19357 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314553AbSEKFZb>;
	Sat, 11 May 2002 01:25:31 -0400
Date: Sat, 11 May 2002 01:25:31 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Frank Davis <fdavis@si.rr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.15 : drivers/md/lvm.c compile error
In-Reply-To: <Pine.LNX.4.33.0205110033550.4235-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.21.0205110124400.20383-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 May 2002, Frank Davis wrote:

> Hello all,
>   I didn't see the following error posted yet, but if I has, sorry in 
> advance.
> 
> Regards,
> Frank
> 
> lvm.c:1:2: #error Broken until maintainers will sanitize kdev_t handling
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Until then it's hopeless.

