Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135621AbRAHK6x>; Mon, 8 Jan 2001 05:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136395AbRAHK6o>; Mon, 8 Jan 2001 05:58:44 -0500
Received: from mailhub2.shef.ac.uk ([143.167.2.154]:15345 "EHLO
	mailhub2.shef.ac.uk") by vger.kernel.org with ESMTP
	id <S135621AbRAHK6h>; Mon, 8 Jan 2001 05:58:37 -0500
Date: Mon, 8 Jan 2001 10:57:32 +0000 (GMT)
From: Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Kdb for modules
Message-ID: <Pine.GSO.4.21.0101081053210.25031-100000@acms23>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> kdb v0.6 is out of date and no longer supported. kdb v1.5 against 
> 2.2.18 is in ftp://oss.sgi.com/projects/kdb/download/ix86/, it supports 
> modules correctly. This patch is only there as a courtesy, SGI do not 
> support kdb on 2.2 kernels, all our debugging work is on 2.4 kernels. 
> If you want to use kdb on 2.2 kernels, you are pretty much on your own. 

Ok, this is fine, but just one question, please: is    
kdb-v1.5-2.2.18-pre15.gz going (or at least supposed to) work with 2.2.18
(final)?

Thanks
Guennadi
___

Dr. Guennadi V. Liakhovetski
Department of Applied Mathematics
University of Sheffield, U.K.
email: G.Liakhovetski@sheffield.ac.uk


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
