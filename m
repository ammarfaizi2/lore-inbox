Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135838AbRDTJn6>; Fri, 20 Apr 2001 05:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135839AbRDTJnt>; Fri, 20 Apr 2001 05:43:49 -0400
Received: from mailhub2.shef.ac.uk ([143.167.2.154]:50405 "EHLO
	mailhub2.shef.ac.uk") by vger.kernel.org with ESMTP
	id <S135838AbRDTJnd>; Fri, 20 Apr 2001 05:43:33 -0400
Date: Fri, 20 Apr 2001 10:43:23 +0100 (BST)
From: Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Hai Xu <xhai@CLEMSON.EDU>, linux-kernel@vger.kernel.org
Subject: Re: A little problem.
In-Reply-To: <E14qMB9-00089Z-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0104201023100.17277-100000@erdos.shef.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is way OT here, but since Alan replied to this, I'll continue this
thread a bit: The interesting bit here, that I don't understand, is - how
in RedHat-7.0, that was released last year, libc is compiled against
2.4.0?... Did they include headers from one of pre / test versions?

Thanks
Guennadi

On Thu, 19 Apr 2001, Alan Cox wrote:

> > and upgrade the Linux Kerenl from their original 2.2.16 to 2.2.18. But when
> > I compile some modules, it said my kernel is 2.4.0. I check the
> > /usr/include/linux/version.h as follows, found that it shows I am using
> > Kernel 2.4.0.
> 
> No. It shows the headers your C compiler libraries are built againt. Which is
> 2.4 - and which is correct. It has nothing to do with the kernel you are 
> running
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

___

Dr. Guennadi V. Liakhovetski
Department of Applied Mathematics
University of Sheffield, U.K.
email: G.Liakhovetski@sheffield.ac.uk


